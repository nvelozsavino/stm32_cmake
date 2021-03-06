# This file should include all the default files generated by the CubeMX

# Set the correct path for the project
set(PROJECT_FILES_PATH ${CMAKE_CURRENT_LIST_DIR}/../../)

# Update this list with the correct HAL sources
set(STM32HAL_SOURCES
        ${PROJECT_FILES_PATH}/Drivers/STM32${STM32_FAMILY_UPPER}xx_HAL_Driver/Src/stm32${STM32_FAMILY_LOWER}xx_hal.c
        ${PROJECT_FILES_PATH}/Drivers/STM32${STM32_FAMILY_UPPER}xx_HAL_Driver/Src/stm32${STM32_FAMILY_LOWER}xx_hal_adc.c
        ${PROJECT_FILES_PATH}/Drivers/STM32${STM32_FAMILY_UPPER}xx_HAL_Driver/Src/stm32${STM32_FAMILY_LOWER}xx_hal_adc_ex.c
        ${PROJECT_FILES_PATH}/Drivers/STM32${STM32_FAMILY_UPPER}xx_HAL_Driver/Src/stm32${STM32_FAMILY_LOWER}xx_hal_can.c
        ${PROJECT_FILES_PATH}/Drivers/STM32${STM32_FAMILY_UPPER}xx_HAL_Driver/Src/stm32${STM32_FAMILY_LOWER}xx_hal_cortex.c
        ${PROJECT_FILES_PATH}/Drivers/STM32${STM32_FAMILY_UPPER}xx_HAL_Driver/Src/stm32${STM32_FAMILY_LOWER}xx_hal_dma.c
        ${PROJECT_FILES_PATH}/Drivers/STM32${STM32_FAMILY_UPPER}xx_HAL_Driver/Src/stm32${STM32_FAMILY_LOWER}xx_hal_flash.c
        ${PROJECT_FILES_PATH}/Drivers/STM32${STM32_FAMILY_UPPER}xx_HAL_Driver/Src/stm32${STM32_FAMILY_LOWER}xx_hal_flash_ex.c
        ${PROJECT_FILES_PATH}/Drivers/STM32${STM32_FAMILY_UPPER}xx_HAL_Driver/Src/stm32${STM32_FAMILY_LOWER}xx_hal_gpio.c
        ${PROJECT_FILES_PATH}/Drivers/STM32${STM32_FAMILY_UPPER}xx_HAL_Driver/Src/stm32${STM32_FAMILY_LOWER}xx_hal_i2c.c
        ${PROJECT_FILES_PATH}/Drivers/STM32${STM32_FAMILY_UPPER}xx_HAL_Driver/Src/stm32${STM32_FAMILY_LOWER}xx_hal_i2c_ex.c
        ${PROJECT_FILES_PATH}/Drivers/STM32${STM32_FAMILY_UPPER}xx_HAL_Driver/Src/stm32${STM32_FAMILY_LOWER}xx_hal_pwr.c
        ${PROJECT_FILES_PATH}/Drivers/STM32${STM32_FAMILY_UPPER}xx_HAL_Driver/Src/stm32${STM32_FAMILY_LOWER}xx_hal_pwr_ex.c
        ${PROJECT_FILES_PATH}/Drivers/STM32${STM32_FAMILY_UPPER}xx_HAL_Driver/Src/stm32${STM32_FAMILY_LOWER}xx_hal_rcc.c
        ${PROJECT_FILES_PATH}/Drivers/STM32${STM32_FAMILY_UPPER}xx_HAL_Driver/Src/stm32${STM32_FAMILY_LOWER}xx_hal_rcc_ex.c
        ${PROJECT_FILES_PATH}/Drivers/STM32${STM32_FAMILY_UPPER}xx_HAL_Driver/Src/stm32${STM32_FAMILY_LOWER}xx_hal_spi.c
        ${PROJECT_FILES_PATH}/Drivers/STM32${STM32_FAMILY_UPPER}xx_HAL_Driver/Src/stm32${STM32_FAMILY_LOWER}xx_hal_spi_ex.c
        ${PROJECT_FILES_PATH}/Drivers/STM32${STM32_FAMILY_UPPER}xx_HAL_Driver/Src/stm32${STM32_FAMILY_LOWER}xx_hal_tim.c
        ${PROJECT_FILES_PATH}/Drivers/STM32${STM32_FAMILY_UPPER}xx_HAL_Driver/Src/stm32${STM32_FAMILY_LOWER}xx_hal_tim_ex.c
        )

# Update this list with the correct HAL Include paths
set(STM32HAL_INCLUDE_DIR
        ${PROJECT_FILES_PATH}/Drivers/STM32${STM32_FAMILY_UPPER}xx_HAL_Driver/Inc
        ${PROJECT_FILES_PATH}/Drivers/STM32${STM32_FAMILY_UPPER}xx_HAL_Driver/Inc/Legacy
        )

# Update this with the correct .s file depending on the MCU
set(CMSIS_SOURCES
        ${CMAKE_CURRENT_LIST_DIR}/../SW4STM32/startup_stm32f042x6.s)

# Update this with the correct .ld file depending on the MCU
SET_LINKER_SCRIPT(${CMAKE_CURRENT_LIST_DIR}/../SW4STM32/portjig/STM32F042K4Tx_FLASH.ld)

# Update this list with the correct CMSIS Include paths
set(CMSIS_INCLUDE_DIRS
        ${PROJECT_FILES_PATH}/Drivers/CMSIS/Include
        )

# Update this list with the correct CMSIS Device Include paths
set(CMSIS_DEVICE_INCLUDE_DIR
        ${PROJECT_FILES_PATH}/Drivers/CMSIS/Device/ST/STM32${STM32_FAMILY_UPPER}xx/Include

        )

# Update this list with the correct files for the sources
set(SOURCE_FILES
        ${PROJECT_FILES_PATH}/Src/main.c
        ${PROJECT_FILES_PATH}/Inc/main.h

        ${PROJECT_FILES_PATH}/Src/stm32${STM32_FAMILY_LOWER}xx_hal_msp.c

        ${PROJECT_FILES_PATH}/Src/stm32${STM32_FAMILY_LOWER}xx_it.c

        ${PROJECT_FILES_PATH}/Src/system_stm32${STM32_FAMILY_LOWER}xx.c

        ${PROJECT_FILES_PATH}/Inc/stm32${STM32_FAMILY_LOWER}xx_hal_conf.h

        ${PROJECT_FILES_PATH}/Inc/stm32${STM32_FAMILY_LOWER}xx_it.h

        ${PROJECT_FILES_PATH}/Src/adc.c
        ${PROJECT_FILES_PATH}/Inc/adc.h

        ${PROJECT_FILES_PATH}/Src/can.c
        ${PROJECT_FILES_PATH}/Inc/can.h

        ${PROJECT_FILES_PATH}/Src/gpio.c
        ${PROJECT_FILES_PATH}/Inc/gpio.h

        ${PROJECT_FILES_PATH}/Src/spi.c
        ${PROJECT_FILES_PATH}/Inc/spi.h

        ${PROJECT_FILES_PATH}/Src/dma.c
        ${PROJECT_FILES_PATH}/Inc/dma.h

        )


# Update this list with the correct includes for the sources
set(SOURCE_INC
        ${PROJECT_FILES_PATH}/Inc
        )



set(SOURCES ${SOURCES}
        ${SOURCE_FILES}
        ${CMSIS_SOURCES}
        ${STM32HAL_SOURCES}
        )

set(STM32_INCLUDE_DIRS
        ${CMSIS_INCLUDE_DIRS}
        ${CMSIS_DEVICE_INCLUDE_DIR}
        ${STM32HAL_INCLUDE_DIR}
        ${SOURCE_INC}
        )

ADD_C_INCLUDES(STM32_INCLUDE_DIRS)
