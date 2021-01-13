cmake_minimum_required(VERSION 3.17)

project(xar_exe)

set(SOURCES
        xar.c)

add_executable(xar_exe ${SOURCES})
set_target_properties(xar_exe PROPERTIES OUTPUT_NAME xar)
target_link_libraries(xar_exe PRIVATE xar)

install(TARGETS xar_exe
    RUNTIME DESTINATION bin)
