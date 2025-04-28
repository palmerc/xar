add_executable( xar_exe xar.c )
target_link_libraries( xar_exe PRIVATE xar OpenSSL::Crypto )
set_target_properties( xar_exe PROPERTIES OUTPUT_NAME xar )

install( TARGETS xar_exe )
