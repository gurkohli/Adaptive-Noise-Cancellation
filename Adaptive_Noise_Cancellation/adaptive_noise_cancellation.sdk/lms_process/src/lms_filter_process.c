/*
 * lms_filter_process.c
 *
 * Main source file. Contains main() function.
 */
#include "lms_filter_process.h"
#include "ZedboardOLED.h"

/* ---------------------------------------------------------------------------- *
 * 									main()										*
 * ---------------------------------------------------------------------------- *
 * Runs all initial setup functions to initialise the audio codec and IP
 * peripherals, before calling the interactive menu system.
 * ---------------------------------------------------------------------------- */
int main(void)
{
	xil_printf("Entering Main\r\n");

	/* Initialize GPIO and NCO peripherals */
	gpio_init();
	nco_init(&Nco);

	xil_printf("GPIO and NCO peripheral configured\r\n");

	xil_printf("ENTERING LMS FILTERING OPERATION\r\n");
	lms_filter();
    return 1;
}

void lms_filter()
{
	u32 nco_in, noise_out, in_left, in_right, out_left_unfiltered, out_left, \
	out_right_unfiltered, out_right, step, prevL, prevR, prevTone, temp, noise_ctrl_sw, prev_noise_ctrl_sw;

	step = 100;

	/* Scale the step size */
	nco_in = step;
	xil_printf("Step = %d, nco_in = %d\r\n",step, nco_in);

	while (1){

		/* Input step size to the NCO core */
		XNco_SetStep_size_v(&Nco, nco_in);

		/* Receive noise sample from noise source */
		noise_ctrl_sw = XGpio_DiscreteRead(&Gpio_noise_src_select, CHANNEL_ONE);

//		usleep(10);
		if (prev_noise_ctrl_sw != noise_ctrl_sw) {
			if (noise_ctrl_sw > 0 ) {
				clear();
				print_message("Noise Source:",0);
				print_message("         Mic",2);
			} else {
				clear();
				print_message("Noise Source:",0);
				print_message("         NCO",2);
			}
		}
		if (noise_ctrl_sw > 0) {
			noise_out = XGpio_DiscreteRead(&Gpio_ext_mic, CHANNEL_ONE);
			if(noise_out!=prevTone) { /* New sinusoidal sample? */
				temp = noise_out >> 2;
			}
		} else {
			noise_out = XNco_GetSine_sample_v(&Nco);
			if(noise_out!=prevTone) { /* New sinusoidal sample? */
				temp = noise_out;
			}
		}
//		 //
//



		in_left = XGpio_DiscreteRead(&Gpio_source, FILTER_INPUT_L);
		in_right = XGpio_DiscreteRead(&Gpio_source, FILTER_INPUT_R);

		/* -------------------------------------------------------------------------------- *
		 * --------------------------------- LEFT CHANNEL --------------------------------- *
		 * -------------------------------------------------------------------------------- */
		if(in_left != prevL) /* New left sample? */
		{
			/* Add noise component to the L+R audio samples */
			out_left_unfiltered = (temp + in_left);
//
			Xil_Out32(LMS_D, out_left_unfiltered); 	// Input audio+noise as desired signal
			Xil_Out32(LMS_X, temp); 		// Input noise as input
			Xil_Out32(LMS_STROBE, 0x01);			// Strobe LMS to signal inputs are finished

			/* Wait until output data is ready */
			out_left = (Xil_In32(LMS_E)); // Output filtered audio

			/* Output audio to the GPIO */
			XGpio_DiscreteWrite(&Gpio_filter_l, FILTER_OUTPUT_UNFILTERED, out_left_unfiltered);
			XGpio_DiscreteWrite(&Gpio_filter_l, FILTER_OUTPUT_FILTERED, out_left);
		}

		/* -------------------------------------------------------------------------------- *
		 * --------------------------------- RIGHT CHANNEL -------------------------------- *
		 * -------------------------------------------------------------------------------- */
		if(in_right != prevR) /* New right sample? */
		{
			/* Add scaled noise component to the L+R audio samples */
			out_right_unfiltered = (temp + in_right);

			Xil_Out32(LMS_D, out_right_unfiltered); 	// Input audio+noise as desired signal
			Xil_Out32(LMS_X, temp); 		// Input noise as input
			Xil_Out32(LMS_STROBE, 0x01);			// Strobe LMS to signal inputs are finished

			/* Wait until output data is ready */
			out_right = (Xil_In32(LMS_E)); // output filtered audio

			/* Output audio to the GPIO */
			XGpio_DiscreteWrite(&Gpio_filter_r, FILTER_OUTPUT_UNFILTERED, out_right_unfiltered);
			XGpio_DiscreteWrite(&Gpio_filter_r, FILTER_OUTPUT_FILTERED, out_right);
		}

		/* Update previous input values */
		prevL = in_left;
		prevR = in_right;
		prevTone = noise_out;
		prev_noise_ctrl_sw = noise_ctrl_sw;
	}

} // LMS filtering

/* ---------------------------------------------------------------------------- *
 * 								gpio_init()									*
 * ---------------------------------------------------------------------------- *
 * Initializes the GPIO drivers
 * ---------------------------------------------------------------------------- */
unsigned char gpio_init()
{
	int Status;

	Status = XGpio_Initialize(&Gpio_filter_l, FILTER_OUTPUT_L_GPIO_ID);
	if(Status != XST_SUCCESS) return XST_FAILURE;

	XGpio_SetDataDirection(&Gpio_filter_l, FILTER_OUTPUT_UNFILTERED, 0x00);
	XGpio_SetDataDirection(&Gpio_filter_l, FILTER_OUTPUT_FILTERED, 0x00);

	Status = XGpio_Initialize(&Gpio_filter_r, FILTER_OUTPUT_R_GPIO_ID);
	if(Status != XST_SUCCESS) return XST_FAILURE;

	XGpio_SetDataDirection(&Gpio_filter_r, FILTER_OUTPUT_UNFILTERED, 0x00);
	XGpio_SetDataDirection(&Gpio_filter_r, FILTER_OUTPUT_FILTERED, 0x00);

	Status = XGpio_Initialize(&Gpio_source, FILTER_SOURCE_INPUT_GPIO_ID);
	if(Status != XST_SUCCESS) return XST_FAILURE;

	XGpio_SetDataDirection(&Gpio_source, FILTER_INPUT_L, 0xff);
	XGpio_SetDataDirection(&Gpio_source, FILTER_INPUT_R, 0xff);

	Status = XGpio_Initialize(&Gpio_ext_mic, EXTERNAL_MIC_IN_ID);
	if(Status != XST_SUCCESS) return XST_FAILURE;

	XGpio_SetDataDirection(&Gpio_ext_mic, CHANNEL_ONE, 0xff);

	Status = XGpio_Initialize(&Gpio_noise_src_select, NOISE_SOURCE_SELECT_GPIO_ID);
	if(Status != XST_SUCCESS) return XST_FAILURE;

	XGpio_SetDataDirection(&Gpio_noise_src_select, CHANNEL_ONE, 0xff);

	return XST_SUCCESS;
}

/* ---------------------------------------------------------------------------- *
 * 								nco_init()									*
 * ---------------------------------------------------------------------------- *
 * Initializes the NCO driver by looking up the configuration in the config
 * table and then initializing it.
 * ---------------------------------------------------------------------------- */
void nco_init(void *InstancePtr){
	XNco_Config *cfgPtr;
	int status;

	/* Initialize the NCO driver so that it's ready to use */

	// Look up the configuration in the config table
	cfgPtr = XNco_LookupConfig(NCO_ID);
	if (!cfgPtr) {
		print("ERROR: Lookup of NCO configuration failed.\n\r");
	}

	// Initialize the NCO driver configuration
	status = XNco_CfgInitialize(InstancePtr, cfgPtr);
	if (status != XST_SUCCESS) {
		print("ERROR: Could not initialize NCO.\n\r");
	}
}
