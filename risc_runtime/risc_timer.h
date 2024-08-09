// ******************** risc_timer.c ***************************************
//                 Risc-Dsp runtime library
//
// Interface to IT and WDT timers using ITSCALE, ITPERIOD and
// ITCSR registers
//
// (c) multicore.ru
//
// *******************************************************************
#ifndef _RISC_TIMER_H_
#define _RISC_TIMER_H_

#define RISC_CLK_PER_MSEC 240000

#ifdef	__cplusplus
extern "C" {
#endif

// Uncomment term below if you don't want dma time counting
//#define DMA_NO_TIME_COUNTING
//by irs
typedef union
{
  unsigned int _val;
  struct
  {
    unsigned key        :8;
    unsigned en         :1;
    unsigned field_int  :1;
    unsigned mode       :1;
    unsigned rld        :1;
    unsigned int_ctr    :2;
    unsigned            :18;
  };
} WDT_CSR;
//end by irs

struct risc_sys_timer
{
  float it_ms_time;
  float dsp_ms_time;
  float dma_ms_time;
};

// Section: Functions

// Function: risc_it_setup
//
// Setup IT timer
//
// Parameters:
//      period - Period of timer. Frequency = CLK/period.
//      clk_src - (0,1,2) - 0 for CPU CLK, 1 for XTI, 2 for RTCXTI
//
// Examples:
//  > risc_it_setup(10000, 0);
//
void risc_it_setup(unsigned int period, int clk_src, int it);

// Function: risc_it_start
//
// Starts IT timer
//
void risc_it_start(int it);

// Function: risc_it_stop
//
// Stops IT timer
//
void risc_it_stop(int it);
#ifdef	__cplusplus
}
#endif

#endif // _RISC_TIMER_H_
