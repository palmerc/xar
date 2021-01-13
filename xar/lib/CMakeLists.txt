cmake_minimum_required(VERSION 3.17)

project(libxar)

set(SOURCES
        archive.c
        arcmod.c
        b64.c
        bzxar.c
        darwinattr.c
        data.c
        ea.c
        err.c
        ext2.c
        fbsdattr.c
        filetree.c
        hash.c
        io.c
        linuxattr.c
        lzmaxar.c
        macho.c
        script.c
        signature.c
        stat.c
        subdoc.c
        util.c
        zxar.c)

set(PUBLIC_HEADERS
        ../include/xar.h)

add_library(xar STATIC ${SOURCES})
target_include_directories(xar PUBLIC ${CMAKE_CURRENT_SOURCE_DIR} ../include)
set_target_properties(xar PROPERTIES PUBLIC_HEADER "${PUBLIC_HEADERS}")

set(CMAKE_FIND_LIBRARY_SUFFIXES .a .tbd)

find_package(OpenSSL REQUIRED)
if(OPENSSL_FOUND)
    target_link_libraries(xar PRIVATE OpenSSL::Crypto)
endif()

find_package(LibXml2 REQUIRED)
if(LibXml2_FOUND)
    target_link_libraries(xar PRIVATE LibXml2::LibXml2)
endif()

find_package(BZip2 REQUIRED)
if(BZIP2_FOUND)
    target_link_libraries(xar PRIVATE BZip2::BZip2)
endif()

find_package(ZLIB REQUIRED)
if(ZLIB_FOUND)
    target_link_libraries(xar PRIVATE ZLIB::ZLIB)
endif()

install(TARGETS xar)