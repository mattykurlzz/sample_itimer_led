################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../main.c 

OBJS_RISC_o += \
./main.o 


# Each subdirectory must supply rules for building sources it contributes
%.o: ../%.c
	@echo 'Building file: $<'
	@echo 'Invoking: RISC C Compiler - mipsel-elf32-gcc'
	"c:\\elvees\\MCStudio_MC-30SF6_2023.08_66"/ToolsMGCC/bin/mipsel-elf32-gcc -DLIB_ELCORE_SDK -DTARGET_MC30SF6 -O0 -g -gdwarf-2 -Wall -EL -mhard-float -DARCH_HAVE_FPU -Wa,-adhlns="$@.lst",-mfix-mc24r2 -c -fmessage-length=0 -G0 -mips32 -ffixed-k0 -ffixed-k1 -mno-check-zero-division -fno-delayed-branch -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


