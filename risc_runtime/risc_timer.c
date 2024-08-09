// ******************** risc_timer.c ***************************************
//                 Risc-Dsp runtime library
//
// Realization of interface to IT and WDT timers using ITSCALE,
// ITPERIOD and ITCSR registers
//
// (c) multicore.ru
//
// *******************************************************************

#include "risc_timer.h"
#include "cpu.h"
#include "risc_interrupt.h"
#include "system.h"

unsigned int _risc_clk_counter = 0;
#ifdef __DMA_TIME_COUNTING__
  extern float _dma_working_time_counter;
#endif

static int get_core () { return 0; }

void risc_it_setup(unsigned int period, int clk_src, int it)
{
	if (it == 0)
	{
		ITSCALE0 = 0;
		ITPERIOD0 = period;
		ITCSR0 = (clk_src << 3);
	}
	else
	{
		ITSCALE1 = 0;
		ITPERIOD1 = period;
		ITCSR1 = (clk_src << 3);
	}
}

void risc_it_start(int it)
{
	if (it == 0)
		ITCSR0 |= 1;
	else
		ITCSR1 |= 1;
}

void risc_it_stop(int it)
{
	if (it == 0)
		ITCSR0 &= 0xfe;
	else
		ITCSR1 &= 0xfe;
}
