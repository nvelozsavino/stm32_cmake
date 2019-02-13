

# this one is important
#this one not so much
SET(CMAKE_SYSTEM_NAME Generic)
SET(CMAKE_SYSTEM_PROCESSOR arm)
enable_language(ASM)
#set(CMAKE_C_STANDARD c99)
# specify the cross compiler
INCLUDE(CMakeForceCompiler)

IF(NOT TARGET_TRIPLET)
    SET(TARGET_TRIPLET "arm-none-eabi")
    IF(NOT TOOLCHAIN_PREFIX)
        MESSAGE(STATUS "No TOOLCHAIN_PREFIX specified, using default: " ${TARGET_TRIPLET})
    else()
        set(TARGET_TRIPLET ${TOOLCHAIN_PREFIX}/bin/arm-none-eabi)
    ENDIF()
    MESSAGE(STATUS "No TARGET_TRIPLET specified, using default: " ${TARGET_TRIPLET})
ENDIF()


SET(CMAKE_SIZE ${TARGET_TRIPLET}-size${TOOL_EXECUTABLE_SUFFIX} CACHE INTERNAL "size tool")



#SET(CMAKE_EXE_LINKER_FLAGS "-mthumb -mcpu=cortex-m4 -mfloat-abi=hard -Wl,--start-group -lc -lm -Wl,--end-group -specs=nosys.specs -mfpu=fpv4-sp-d16  -nostartfiles -nodefaultlibs -static -Wl,-cref,-u,-Xlinker,--defsym=ST_LINKER_OPTION=1 -Wl,-Map=output.map -Wl,--gc-sections" CACHE INTERNAL "executable linker flags")
#add_definitions(${C_FLAGS})
#-Wl,--start-group -lc -lm -Wl,--end-group -specs=nosys.specs -nostartfiles -nodefaultlibs -static -Wl,-cref,-u,-Xlinker,--defsym=ST_LINKER_OPTION=1 -Wl,-Map=output.map -Wl,--gc-sections -Wl,--defsym=malloc_getpagesize_P=0x80
IF (WIN32)
    SET(TOOL_EXECUTABLE_SUFFIX ".exe")
ELSE()
    SET(TOOL_EXECUTABLE_SUFFIX "")
ENDIF()


set(CMAKE_C_FLAGS_DEBUG "")
set(CMAKE_C_FLAGS_RELEASE "")
set(CMAKE_C_FLAGS_MINSIZEREL "")
set(CMAKE_C_FLAGS_RELWITHDEBINFO "")

set(CMAKE_CXX_FLAGS_DEBUG "")
set(CMAKE_CXX_FLAGS_RELEASE "")
set(CMAKE_CXX_FLAGS_MINSIZEREL "")
set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "")

set(CMAKE_ASM_FLAGS_DEBUG "")
set(CMAKE_ASM_FLAGS_RELEASE  "")
set(CMAKE_ASM_FLAGS_MINSIZEREL   "")
set(CMAKE_ASM_FLAGS_RELWITHDEBINFO "")

set(CMAKE_EXE_LINKE_FLAGS_DEBUG "")
set(CMAKE_EXE_LINKE_FLAGS_RELEASE  "")
set(CMAKE_EXE_LINKE_FLAGS_MINSIZEREL   "")
set(CMAKE_EXE_LINKE_FLAGS_RELWITHDEBINFO "")


set(CMAKE_C_FLAGS "" CACHE INTERNAL "c compiler flags")
set(CMAKE_CXX_FLAGS "" CACHE INTERNAL "c++ compiler flags")
set(CMAKE_ASM_FLAGS "" CACHE INTERNAL "asm compiler flags")


set(LDFLAGS
        ${LDFLAGS_1}
        ${LDFLAGS_2}
        )
string(REPLACE ";" " " LDFLAGS "${LDFLAGS}")
set(CMAKE_EXE_LINKER_FLAGS "${LDFLAGS}" CACHE INTERNAL "executable linker flags")


#set(C_COMPILER ${TOOLCHAIN_BIN_DIR}/${TARGET_TRIPLET}-gcc${TOOL_EXECUTABLE_SUFFIX})
set(C_COMPILER ${TARGET_TRIPLET}-gcc${TOOL_EXECUTABLE_SUFFIX})
#set(CXX_COMPILER ${TOOLCHAIN_BIN_DIR}/${TARGET_TRIPLET}-g++${TOOL_EXECUTABLE_SUFFIX})
set(CXX_COMPILER ${TARGET_TRIPLET}-g++${TOOL_EXECUTABLE_SUFFIX})

if( ${CMAKE_VERSION} VERSION_LESS 3.6.0)
    include(CMakeForceCompiler)
    CMAKE_FORCE_C_COMPILER( ${C_COMPILER} GNU)
    CMAKE_FORCE_CXX_COMPILER( ${CXX_COMPILER} GNU)
else()
    set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
    set(CMAKE_C_COMPILER ${C_COMPILER} )
    set(CMAKE_CXX_COMPILER ${CXX_COMPILER} )
endif()



#SET(CMAKE_ASM_COMPILER ${TOOLCHAIN_BIN_DIR}/${TARGET_TRIPLET}-as${TOOL_EXECUTABLE_SUFFIX})
SET(CMAKE_ASM_COMPILER ${TARGET_TRIPLET}-as${TOOL_EXECUTABLE_SUFFIX})
#set(CMAKE_OBJCOPY ${TOOLCHAIN_BIN_DIR}/${TARGET_TRIPLET}-objcopy${TOOL_EXECUTABLE_SUFFIX})
set(CMAKE_OBJCOPY ${TARGET_TRIPLET}-objcopy${TOOL_EXECUTABLE_SUFFIX})
# where is the target environment

# search for programs in the build host directories
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# for libraries and headers in the target directories
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

#set(LINER_SCRIPT "")
FUNCTION(SET_LINKER_SCRIPT LINKER_SCRIPT)
#    string(REPLACE " " "\\ " LINKER_SCRIPT "${LINKER_SCRIPT}")
        message(STATUS "Linker script: ${LINKER_SCRIPT}")
    set(LDFLAGS
            ${LDFLAGS_1}
            -T"${LINKER_SCRIPT}"
            ${LDFLAGS_2}
            )
    string(REPLACE ";" " " LDFLAGS "${LDFLAGS}")
    set(CMAKE_EXE_LINKER_FLAGS "${LDFLAGS}" PARENT_SCOPE)
#    set(LINER_SCRIPT "-T${CMAKE_CURRENT_SOURCE_DIR}/${LINKER_SCRIPT}" PARENT_SCOPE)
ENDFUNCTION()



set(C_DEFINES "")
set(C_INCLUDES "")
function(ADD_C_DEFINE FLAG)
    set(C_DEFINES ${C_DEFINES} ${FLAG} PARENT_SCOPE)
endfunction()

function(ADD_C_INCLUDES INCLUDES)
    foreach(INCLUDE ${${INCLUDES}})
        set(CINC
                ${CINC}
                "-I${INCLUDE}")
    endforeach()
    set(C_INCLUDES
            ${C_INCLUDES}
            ${CINC}
            PARENT_SCOPE)
endfunction()




FUNCTION(SET_COMPILER_OPTIONS TARGET)
    set(CFLAGS
            ${CFLAGS_1}
            ${C_DEFINES}
            ${C_INCLUDES}
            ${CFLAGS_2}
            )

    target_compile_options(${TARGET} PRIVATE
            $<$<COMPILE_LANGUAGE:C>:${CFLAGS}>
            $<$<COMPILE_LANGUAGE:CXX>:${CXXFLAGS}>
            $<$<COMPILE_LANGUAGE:ASM>:${ASMFLAGS}>
            )
ENDFUNCTION()
