/****************************************************************
 *                  SIMPLE_INTERRUPT_ITIMER_FLASH               *
 * Демонстрирует обработку прерываний от интервального таймера. *
 * В конце программы значение interrupt_counter                 *
 * должно быть равным 10                                        *
 * ExitStatus = 0;                                              *
 ***************************************************************/
//#define TARGET_MC24R
//#define TARGET_MC0428

//#define TARGET_MCT03P
//#define TARGET_MCT04
//#define TARGET_MCT05
//#define TARGET_MCT06
//#define TARGET_MCT08

#include "risc_runtime/cpu.h"
#include "risc_runtime/risc_interrupt.h"
#include "risc_runtime/risc_timer.h"
#include "risc_runtime/erlcommon.h"

#define LDAT7 (1<<9) //значение для перевода канала в режим вывода
enum IT
{
	IT0,
	IT1
};

RISC_INTERRUPT_TYPE int_t = INTH_80000180;


int interrupt_counter_it0 = 0;
int interrupt_counter_it1 = 0;
int ExitStatus = 3;

void flash_interrupt_on();

void int_handler(int a) 
{

	if ( (ITCSR0 & 2) == 2 ){
//		risc_it_stop(IT0);
		ITCSR0 &= ~(2);
		//risc_disable_interrupt(RISC_INT_IT0,0);
		//flash_interrupt_on();
		interrupt_counter_it0++;
	}
	return;
}

void flash_interrupt_off()
{
	// turn the led off
	risc_it_stop(IT1);

	MFBSP3_GPIO &= ~(LDAT7);

	interrupt_counter_it1++;
	return;
}

void flash_interrupt_on()
{
	// turn on the led
	MFBSP3_DIR = LDAT7;
	int period = (unsigned int) 0x7fff;

	MFBSP3_GPIO = LDAT7;

	// setup the time
//	risc_it_setup(0x3fff, 2, IT1);
//	risc_it_start(IT1);
	return;
}

void SetCP0_Status(unsigned int value) {
    asm volatile ("mtc0 %0, $12" ::"r"(value));
}

int main() {

	risc_set_interrupts_vector(int_t);		//выставляет биты ERL и BEV регистра status для прерываний
	risc_enable_interrupt(RISC_INT_IT0,0);	//разрешает прерывания типа RISC_INT_IT0
	risc_enable_interrupt(RISC_INT_IT1,0);	//разрешает прерывания типа RISC_INT_IT1

	enum ERL_ERROR error_status_it0 = risc_register_interrupt(int_handler, RISC_INT_IT0);
	enum ERL_ERROR error_status_it1 = risc_register_interrupt(flash_interrupt_off, RISC_INT_IT1);
											//регистрирует обработчик прерываний RISC_INT_IT0

	risc_it_setup(0x7fff, 2, IT0);			//задает период и источник прерывания.
	risc_it_start(IT0);

    while (interrupt_counter_it0<5);

//    risc_it_setup(0x3fff, 2, IT1);
//    risc_it_start(IT1);
//    risc_it_setup(0x7fff, 2, IT0);			//задает период и источник прерывания.
//	risc_it_start(IT0);

//    while (interrupt_counter_it0==1);

    if (interrupt_counter_it0 == 5)
    {
  	  ExitStatus = 0;
    }
    else
    {
  	  ExitStatus=1;
    }

    return ExitStatus;
}
