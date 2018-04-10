/*
 * File Name:         hdl_prj\ipcore\lms_filter_ipcore_v1_0\include\lms_filter_ipcore_addr.h
 * Description:       C Header File
 * Created:           2018-04-02 19:23:34
*/

#ifndef LMS_FILTER_IPCORE_H_
#define LMS_FILTER_IPCORE_H_

#define  IPCore_Reset_lms_filter_ipcore    0x0  //write 0x1 to bit 0 to reset IP core
#define  IPCore_Enable_lms_filter_ipcore   0x4  //enabled (by default) when bit 0 is 0x1
#define  IPCore_Strobe_lms_filter_ipcore   0x8  //write 1 to bit 0 after write all input data
#define  IPCore_Ready_lms_filter_ipcore    0xC  //wait until bit 0 is 1 before read output data
#define  x_k__Data_lms_filter_ipcore       0x100  //data register for port x(k)
#define  d_k__Data_lms_filter_ipcore       0x104  //data register for port d(k)
#define  e_k__Data_lms_filter_ipcore       0x108  //data register for port e(k)
#define  o_k__Data_lms_filter_ipcore       0x10C  //data register for port o(k)

#endif /* LMS_FILTER_IPCORE_H_ */
