

set(STM32_FAMILY "f3")

if (NOT DEFINED OPTIMIZATION)
    set(OPTIMIZATION -Os)
endif()

if (NOT DEFINED DEBUG_LEVEL)
    set(DEBUG_LEVEL -g3)
endif()



set(CFLAGS_1
        -mcpu=cortex-m4
        -mthumb
        -mfloat-abi=hard
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
        -mcpu=cortex-m4
        -mthumb
        -mfloat-abi=hard
        -g
        )

set(CXXFLAGS "")

set(LDFLAGS_1
        -mcpu=cortex-m4
        -mthumb
        -mfloat-abi=hard
        -specs=nosys.specs
        #        -specs=nano.specs
        -mfpu=fpv4-sp-d16
        )


set(LDFLAGS_2
        -Wl,-Map=output.map -Wl,--gc-sections
        )


set(OPENOCD_CFG "board/st_nucleo_f3.cfg")

include(arm-toolchain)
include(stm32)