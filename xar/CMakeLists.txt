cmake_minimum_required( VERSION 3.23 )

project( xar LANGUAGES C )

set( XAR_MAJOR_VERSION "1" )
set( XAR_MINOR_VERSION "6.1" )
set( XAR_NUMERIC_VERSION "0x01060180" )
set( XAR_VERSION "${XAR_MAJOR_VERSION}.${XAR_MINOR_VERSION}" )

find_package( LibXml2 REQUIRED )
find_package( BZip2 REQUIRED )
find_package( ZLIB REQUIRED )

set( OPENSSL_USE_STATIC_LIBS on )
find_package( OpenSSL COMPONENTS Crypto REQUIRED )

if( CMAKE_SYSTEM_NAME MATCHES "Linux" )
	add_definitions( -D_DEFAULT_SOURCE )
	add_definitions( -D_BSD_SOURCE )
	add_definitions( -D_POSIX_SOURCE )
	add_definitions( -D_GNU_SOURCE )
endif()

add_subdirectory( lib )
add_subdirectory( include )
add_subdirectory( src )
