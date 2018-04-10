/*
 * lms_filter_process.h
 *
 * Main header file.
 */

#ifndef LMS_FILTER_PROC_H
#define LMS_FILTER_PROC_H

/* ---------------------------------------------------------------------------- *
 * 								Header Files									*
 * ---------------------------------------------------------------------------- */
#include <stdio.h>
#include <xil_io.h>
#include <sleep.h>
#include <xil_printf.h>
#include <xparameters.h>
#include "xgpio.h"
#include "xuartps.h"
#include "stdlib.h"

/* ---------------------------------------------------------------------------- *
 * 							Custom IP Header Files								*
 * ---------------------------------------------------------------------------- */
#include "lms_pcore_addr.h"
#include "xnco.h"

/* ---------------------------------------------------------------------------- *
 * 							Prototype Functions									*
 * ---------------------------------------------------------------------------- */

void lms_filter();
unsigned char gpio_init();
void nco_init(void *InstancePtr);

/* ---------------------------------------------------------------------------- *
 * 						Redefinitions from xparameters.h 						*
 * ---------------------------------------------------------------------------- */
#define NCO_ID XPAR_NUMERIC_OSCILLATOR_DEVICE_ID

#define LMS_LOC XPAR_LMS_FILTER_BASEADDR
#define LMS_X LMS_LOC + x_k__Data_lms_pcore
#define LMS_D LMS_LOC + d_k__Data_lms_pcore
#define LMS_E LMS_LOC + e_k__Data_lms_pcore
#define LMS_STROBE LMS_LOC + IPCore_Strobe_lms_pcore

#define UART_BASEADDR XPAR_PS7_UART_1_BASEADDR

#define FILTER_OUTPUT_L_GPIO_LOC XPAR_FILTER_OUTPUT_LEFT_BASEADDR
#define FILTER_OUTPUT_L_GPIO_ID XPAR_FILTER_OUTPUT_LEFT_DEVICE_ID

#define FILTER_OUTPUT_R_GPIO_LOC XPAR_FILTER_OUTPUT_RIGHT_BASEADDR
#define FILTER_OUTPUT_R_GPIO_ID XPAR_FILTER_OUTPUT_RIGHT_DEVICE_ID

#define FILTER_SOURCE_INPUT_GPIO_LOC XPAR_INPUT_SOURCE_BASEADDR
#define FILTER_SOURCE_INPUT_GPIO_ID XPAR_INPUT_SOURCE_DEVICE_ID

#define EXTERNAL_MIC_IN_LOC XPAR_EXTERNAL_MIC_AXI_INTF_BASEADDR
#define EXTERNAL_MIC_IN_ID XPAR_EXTERNAL_MIC_AXI_INTF_DEVICE_ID

#define NOISE_SOURCE_SELECT_GPIO_LOC XPAR_NOISE_SOURCE_SELECT_SW_BASEADDR
#define NOISE_SOURCE_SELECT_GPIO_ID XPAR_NOISE_SOURCE_SELECT_SW_DEVICE_ID


/* ---------------------------------------------------------------------------- *
 * 							Define GPIO Channels								*
 * ---------------------------------------------------------------------------- */
#define FILTER_OUTPUT_UNFILTERED 1
#define FILTER_OUTPUT_FILTERED 2

#define FILTER_INPUT_L 1
#define FILTER_INPUT_R 2

#define CHANNEL_ONE 1

/* ---------------------------------------------------------------------------- *
 * 							Audio Scaling Factor								*
 * ---------------------------------------------------------------------------- */
#define SCALE 6

/* ---------------------------------------------------------------------------- *
 * 							Global Variables									*
 * ---------------------------------------------------------------------------- */
XGpio Gpio_filter_l, Gpio_filter_r, Gpio_source, Gpio_ext_mic, Gpio_noise_src_select;
XNco Nco;


#endif /* LMS_FILTER_PROC_H */
