include( CheckIncludeFiles )
include( CheckLibraryExists )
include( CheckSymbolExists )
include( CheckTypeSize )

set( HEADERS_TO_CHECK
        ext2fs/ext2_fs.h
        libutil.h
        stdio.h
        string.h
        sys/attr.h
        sys/extattr.h
        sys/param.h
        sys/statfs.h
        sys/xattr.h
        unistd.h )

set( FUNCTIONS_TO_CHECK
        asprintf
        chflags
        getattrlist
        getxattr
        lchown
        lchmod
        lgetxattr
        lsetxattr
        setattrlist
        setxattr
        strmode
        statfs )

macro( MANGLE_VARIABLE_NAME str var prefix )
    STRING( TOUPPER "${str}" mangle_variable_name_var )
    STRING( REGEX REPLACE "[/. ]" "_" mangle_variable_name_var "${mangle_variable_name_var}" )
    SET( ${var} "${prefix}${mangle_variable_name_var}" )
endmacro( MANGLE_VARIABLE_NAME str var prefix )

macro( CHECK_INCLUDE_FILE_CONCAT FILE )
    MANGLE_VARIABLE_NAME( "${FILE}" "CHECK_INCLUDE_FILE_CONCAT_VAR" "HAVE_" )
    CHECK_INCLUDE_FILES("${HEADER_INCLUDES};${FILE}" ${CHECK_INCLUDE_FILE_CONCAT_VAR})
    if( ${CHECK_INCLUDE_FILE_CONCAT_VAR} )
        set( HEADER_INCLUDES ${HEADER_INCLUDES} ${FILE} )
    endif( ${CHECK_INCLUDE_FILE_CONCAT_VAR} )
endmacro( CHECK_INCLUDE_FILE_CONCAT )

macro( CHECK_SYMBOL_EXISTS_EX SYMBOL )
    MANGLE_VARIABLE_NAME( "${SYMBOL}" "CHECK_SYMBOL_EXISTS_EX_VAR" "HAVE_" )
    check_symbol_exists( "${SYMBOL}" "${HEADER_INCLUDES}" "${CHECK_SYMBOL_EXISTS_EX_VAR}" )
endmacro( CHECK_SYMBOL_EXISTS_EX SYMBOL )


foreach( HEADER_TO_CHECK ${HEADERS_TO_CHECK} )
    CHECK_INCLUDE_FILE_CONCAT( "${HEADER_TO_CHECK}" )
endforeach( HEADER_TO_CHECK )

foreach( FUNCTION_TO_CHECK ${FUNCTIONS_TO_CHECK} )
    CHECK_SYMBOL_EXISTS_EX( "${FUNCTION_TO_CHECK}" )
endforeach( FUNCTION_TO_CHECK )


check_type_size( uid_t UID_TYPE_SIZE )
if( UID_TYPE_SIZE EQUAL 4 )
    set( UID_STRING RId32 )
    set( UID_CAST "(uint32_t)" )
elseif( UID_TYPE_SIZE EQUAL 8 )
    set( UID_STRING PRId64 )
    set( UID_CAST "(uint64_t)" )
else()
    message( FATAL_ERROR cannot detect the size of your system's uid_t type )
endif()

check_type_size( gid_t GID_TYPE_SIZE )
if( GID_TYPE_SIZE EQUAL 4 )
    set( GID_STRING PRId32 )
    set( GID_CAST "(uint32_t)" )
elseif( GID_TYPE_SIZE EQUAL 8 )
    set( GID_STRING PRId64 )
    set( GID_CAST "(uint64_t)" )
else()
    message( FATAL_ERROR cannot detect the size of your system's gid_t type )
endif()

check_type_size( ino_t INO_TYPE_SIZE )
if( INO_TYPE_SIZE EQUAL 4 )
    set( INO_STRING PRId32 )
    set( INO_HEXSTRING PRIx32 )
    set( INO_CAST "(uint32_t)" )
elseif( INO_TYPE_SIZE EQUAL 8 )
    set( INO_STRING PRId64 )
    set( INO_HEXSTRING PRIx64 )
    set( INO_CAST "(uint64_t)" )
else()
message( FATAL_ERROR cannot detect the size of your system's ino_t type )
endif()

check_type_size( dev_t DEV_TYPE_SIZE )
if( DEV_TYPE_SIZE EQUAL 4 )
    set( DEV_STRING PRId32 )
    set( DEV_HEXSTRING PRIx32 )
    set( DEV_CAST "(uint32_t)" )
elseif( DEV_TYPE_SIZE EQUAL 8 )
    set( DEV_STRING PRId64 )
    set( DEV_HEXSTRING PRIx64 )
    set( DEV_CAST "(uint64_t)" )
else()
    message( FATAL_ERROR cannot detect the size of your system's dev_t type )
endif()

configure_file( config.h.in config.h )
configure_file( xar.h.in xar.h )

target_sources( libxar
        PUBLIC
        FILE_SET public_headers
        BASE_DIRS ${CMAKE_CURRENT_BINARY_DIR}
        TYPE HEADERS
        FILES
            ${CMAKE_CURRENT_BINARY_DIR}/config.h
            ${CMAKE_CURRENT_BINARY_DIR}/xar.h )

