

set(STM32_FAMILY "f4")

if (NOT DEFINED OPTIMIZATION)
    set(OPTIMIZATION -Os)
endif()

if (NOT DEFINED DEBUG_LEVEL)
    set(DEBUG_LEVEL -g3)
endif()



set(CFLAGS_1
        -mcpu=cortex-m4
        -std=c99
        ${DEBUG_LEVEL}
#        -fno-builtin
#        -fshort-enums
        #        -mthumb
#        -mfloat-abi=hard
        )
set(CFLAGS_2
        -c)

set(CFLAGS_3
        ${OPTIMIZATION}

        -ffunction-sections
        -Wall
        -fstack-usage
#        --specs=nano.specs
        -mfpu=fpv4-sp-d16
        -mfloat-abi=hard
        -mthumb
        -pedantic
        -Werror
#        -fmessage-length=0
#
#        -fmessage-length=0
        )


set(ASMFLAGS
        -mcpu=cortex-m4
        ${DEBUG_LEVEL}
        -c
        -x assembler-with-cpp
#        --specs=nano.specs
        -mfpu=fpv4-sp-d16
        -mfloat-abi=hard
        -mthumb
        )

set(CXXFLAGS "")

set(LDFLAGS_1
        -mcpu=cortex-m4

        #        -specs=nano.specs
        )


set(LDFLAGS_2
        -std=c99
        -Wl,-Map=output.map
        -Wl,--gc-sections
        -static
        --specs=nosys.specs
        -mfpu=fpv4-sp-d16
        -mfloat-abi=hard
        -mthumb
        -Wl,--start-group
        -lc
        -lm
        -lnosys
        -Wl,--end-group

        )

if (NOT OPENOCD_CFG)
set(OPENOCD_CFG "board/st_nucleo_f4.cfg")
endif()
message(STATUS "Using OpenOCD cfg: ${OPENOCD_CFG}")
include(arm-toolchain)
include(stm32)