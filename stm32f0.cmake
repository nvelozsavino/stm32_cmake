
#arm-none-eabi-gcc -mcpu=cortex-m0 -mthumb -mfloat-abi=soft '-D__weak=__attribute__((weak))' '-D__packed="__attribute__((__packed__))"' -DUSE_HAL_DRIVER -DSTM32F042x6 -I"/home/nico/Documents/Unlimited/firmware/jigs/port_tester/Inc" -I"/home/nico/Documents/Unlimited/firmware/jigs/port_tester/Drivers/STM32F0xx_HAL_Driver/Inc" -I"/home/nico/Documents/Unlimited/firmware/jigs/port_tester/Drivers/STM32F0xx_HAL_Driver/Inc/Legacy" -I"/home/nico/Documents/Unlimited/firmware/jigs/port_tester/Drivers/CMSIS/Device/ST/STM32F0xx/Include" -I"/home/nico/Documents/Unlimited/firmware/jigs/port_tester/Drivers/CMSIS/Include"  -Og -g3 -Wall -fmessage-length=0 -ffunction-sections -c -fmessage-length=0 -MMD -MP -MF"Drivers/STM32F0xx_HAL_Driver/stm32f0xx_hal_flash_ex.d" -MT"Drivers/STM32F0xx_HAL_Driver/stm32f0xx_hal_flash_ex.o" -o "Drivers/STM32F0xx_HAL_Driver/stm32f0xx_hal_flash_ex.o" "/home/nico/Documents/Unlimited/firmware/jigs/port_tester/Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal_flash_ex.c"

#arm-none-eabi-as -mcpu=cortex-m0 -mthumb -mfloat-abi=soft -g -o "Application/SW4STM32/startup_stm32f042x6.o" "/home/nico/Documents/Unlimited/firmware/jigs/port_tester/toolchain/SW4STM32/startup_stm32f042x6.s"

#arm-none-eabi-gcc -mcpu=cortex-m0 -mthumb -mfloat-abi=soft -specs=nosys.specs -specs=nano.specs -T"../STM32F042K4Tx_FLASH.ld" -Wl,-Map=output.map -Wl,--gc-sections -o "portjig.elf" @"objects.list"   -lm


set(STM32_FAMILY "f0")

if (NOT DEFINED OPTIMIZATION)
    set(OPTIMIZATION -Os)
endif()

if (NOT DEFINED DEBUG_LEVEL)
    set(DEBUG_LEVEL -g3)
endif()


set(CFLAGS_1
        -mcpu=cortex-m0
        -mthumb
        -mfloat-abi=soft
        -std=c99
        -D__weak=__attribute__\(\(weak\)\)
        -D__packed=__attribute__\(\(__packed__\)\)
        )

set(CFLAGS_2
        ${OPTIMIZATION}
        ${DEBUG_LEVEL}
        -pedantic
        -Wall
        -Werror
        -fmessage-length=0
        -ffunction-sections
        -c
        -fmessage-length=0
        )

set(ASMFLAGS
        -mcpu=cortex-m0
        -mthumb
        -mfloat-abi=soft
        -g
        )
set(CXXFLAGS "")

set(LDFLAGS_1
        -mcpu=cortex-m0
        -mthumb
        -mfloat-abi=soft
        -specs=nosys.specs
        -specs=nano.specs
        )

set(LDFLAGS_2
        -Wl,-Map=output.map -Wl,--gc-sections -Wl,--cref
        )

set(OPENOCD_CFG "board/st_nucleo_f0.cfg")

include(arm-toolchain)
include(stm32)