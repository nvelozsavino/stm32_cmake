


IF(STM32_FAMILY)
    STRING(TOLOWER ${STM32_FAMILY} STM32_FAMILY_LOWER)
    STRING(TOUPPER ${STM32_FAMILY} STM32_FAMILY_UPPER)
    set(STM32_HAL_H_FILE stm32${STM32_FAMILY_LOWER}xx_hal.h)
    set(STM32_H_FILE stm32${STM32_FAMILY_LOWER}xx.h)
    ADD_C_DEFINE(-DSTM32_HAL_H_FILE="${STM32_HAL_H_FILE}")
    ADD_C_DEFINE(-DSTM32_H_FILE="${STM32_H_FILE}")
else()
    message(FATAL_ERROR "No STM32_FAMILY")
endif()
if (DONT_USE_HAL_DRIVER)
    message(STATUS "Not using -DUSE_HAL_DRIVER")
else()
    ADD_C_DEFINE(-DUSE_HAL_DRIVER)
endif()

FUNCTION(STM32_ADD_HEX_BIN_TARGETS TARGET OUTPUT)
    get_filename_component(OUTPUT_PATH ${OUTPUT} DIRECTORY)
    message(STATUS "Output directory ${OUTPUT_PATH}")
    add_custom_command(TARGET ${TARGET} POST_BUILD COMMAND ${CMAKE_COMMAND} -E make_directory ${OUTPUT_PATH})
    add_custom_command(TARGET ${TARGET} POST_BUILD COMMAND ${CMAKE_OBJCOPY} ${TARGET} ${OUTPUT}.elf)
    add_custom_command(TARGET ${TARGET} POST_BUILD COMMAND ${CMAKE_OBJCOPY} -Oihex ${TARGET} ${OUTPUT}.hex)
    add_custom_command(TARGET ${TARGET} POST_BUILD COMMAND ${CMAKE_OBJCOPY} -Oihex ${TARGET} ${TARGET}.hex)
    add_custom_command(TARGET ${TARGET} POST_BUILD COMMAND ${CMAKE_OBJCOPY} -Obinary ${TARGET} ${OUTPUT}.bin)
ENDFUNCTION()

FUNCTION(STM32_PRINT_SIZE_OF_TARGETS TARGET)
    IF(EXECUTABLE_OUTPUT_PATH)
        SET(FILENAME "${EXECUTABLE_OUTPUT_PATH}/${TARGET}")
    ELSE()
        SET(FILENAME "${TARGET}")
    ENDIF()
    add_custom_command(TARGET ${TARGET} POST_BUILD COMMAND ${CMAKE_SIZE} ${FILENAME})
ENDFUNCTION()


function(BUILD_UPG TARGET NAME BINARY_FILE OUTPUT_FILE PID VERSION MIN_VERSION)
    find_program(BIN2UPG bin2upg)
    if(BIN2UPG)
        add_custom_target(${NAME}
                DEPENDS ${TARGET} ${BINARY_FILE}
                COMMAND ${BIN2UPG} -b ${BINARY_FILE} -o ${OUTPUT_FILE} -p ${PID} -f ${VERSION} -m ${MIN_VERSION}
                )
    endif()
endfunction()



FUNCTION(STM32_FLASH_TARGET TARGET)
    if (NOT OPENOCD_BIN)
        find_program(OPENOCD openocd)
        set(OPENOCD_BIN ${OPENOCD})
    endif()
    if (OPENOCD_BIN AND OPENOCD_CFG)
        message(STATUS "OpenOCD bin: ${OPENOCD_BIN}")
        message(STATUS "OpenOCD cfg: ${OPENOCD_CFG}")
        if (NOT OPENOCD_RESET_CFG)
            set (OPENOCD_RESET_CFG "none")
        endif()
        set(FILE ${CMAKE_BINARY_DIR}/${TARGET})
        #        message(STATUS ${FILE}.hex)
        GET_FILENAME_COMPONENT(FILE_PATH "${FILE}" ABSOLUTE)
        if (WIN32 OR WIN64)
            set(FLASH_CMD "-c \"reset_config ${OPENOCD_RESET_CFG}\" -c \"program \"${FILE_PATH}.hex\" verify\"" )
        else()
            set(FLASH_CMD -c "reset_config ${OPENOCD_RESET_CFG}" -c "program \"${FILE_PATH}.hex\" verify" )
        endif()
        message(STATUS "FLASH CMD: ${FLASH_CMD}")
        if (HLA_SERIAL)
            if (WIN32 OR WIN64)
                set(FLASH_CMD "-c \"hla_serial ${HLA_SERIAL}\" ${FLASH_CMD}")
            else()
                set(FLASH_CMD -c "hla_serial ${HLA_SERIAL}"
                    ${FLASH_CMD})
            endif()
        endif()

        if (OPENOCD_SCRIPT)
            set(OPENOCD_SCRIPT_CMD "-s ${OPENOCD_SCRIPT}")
        else()
            set(OPENOCD_SCRIPT_CMD "")
        endif()
        get_filename_component(OUTPUT_PATH ${FILE} DIRECTORY)
        if (WIN32)
            string(REPLACE ";" "<->" L2 "${OPENOCD_CMD}")
        endif()
        message(STATUS "FLASH CMD: ${FLASH_CMD}")
        add_custom_target(Flash
                DEPENDS ${TARGET}
                COMMAND ${CMAKE_COMMAND} -E make_directory ${OUTPUT_PATH}
                COMMAND ${CMAKE_OBJCOPY} -Oihex ${FILE} ${FILE}.hex
                COMMAND ${OPENOCD_BIN} -f ${OPENOCD_CFG} ${OPENOCD_SCRIPT_CMD} ${FLASH_CMD} -c "reset run" -c "exit"
                WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} USES_TERMINAL)

        add_custom_target(Flash-Debug
                DEPENDS ${TARGET}
                COMMAND ${CMAKE_COMMAND} -E make_directory ${OUTPUT_PATH}
                COMMAND ${CMAKE_OBJCOPY} -Oihex ${FILE} ${FILE}.hex
                COMMAND ${OPENOCD_BIN} -f ${OPENOCD_CFG} ${OPENOCD_SCRIPT_CMD} ${FLASH_CMD} -c "reset halt" -c "exit"
                WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} USES_TERMINAL)
    else()
        if (NOT OPENOCD_BIN)
            message(WARNING "OpenOCD binary not found")
        endif()
        if (NOT OPENOCD_CFG)
            message(WARNING "OpenOCD CFG not set")
        endif()
    endif()
ENDFUNCTION()
