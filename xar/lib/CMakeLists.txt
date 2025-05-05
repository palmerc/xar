cmake_minimum_required( VERSION 3.23 )

project( libxar )


add_library( libxar STATIC )
target_include_directories( libxar
        PUBLIC
            ${CMAKE_CURRENT_SOURCE_DIR}
            ${CMAKE_CURRENT_BINARY_DIR}/../include
            ${CMAKE_CURRENT_BINARY_DIR}/../include/xar )
target_link_libraries( libxar
        PRIVATE
            BZip2::BZip2
            ZLIB::ZLIB
            LibXml2::LibXml2
            OpenSSL::Crypto )
set_target_properties( libxar PROPERTIES
        OUTPUT_NAME xar
        PUBLIC_HEADER
            ${CMAKE_CURRENT_BINARY_DIR}/../include/xar.h )

target_sources( libxar
        PUBLIC
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
            zxar.c )

install( TARGETS libxar 
	 PUBLIC_HEADER DESTINATION include/xar )
