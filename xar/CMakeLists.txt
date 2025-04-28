cmake_minimum_required( VERSION 3.23 )

project( xar LANGUAGES C )

set( XAR_MAJOR_VERSION "1" )
set( XAR_MINOR_VERSION "6.1" )
set( XAR_NUMERIC_VERSION "0x01060180" )
set( XAR_VERSION "${XAR_MAJOR_VERSION}.${XAR_MINOR_VERSION}" )

set( OPENSSL_USE_STATIC_LIBS on )

set( OPENSSL_ROOT_DIR /opt/homebrew/opt/libressl )
set( CMAKE_FIND_LIBRARY_SUFFIXES .a .tbd )

find_package( OpenSSL REQUIRED )
find_package( LibXml2 REQUIRED )
find_package( BZip2 REQUIRED )
find_package( ZLIB REQUIRED )

add_subdirectory( lib )
add_subdirectory( include )
add_subdirectory( src )
