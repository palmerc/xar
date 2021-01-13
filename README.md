## xar - eXtensible ARchiver

Apple's now deprecated `xar` utiltity with dependence on CommonCrypto stripped in favor of OpenSSL 1.0 (or LibreSSL). Added CMake build.

You probably need to add OPENSSL_ROOT_DIR if you're on macOS. The other dependencies (libxml2, libbz2, and libz) should be found in Xcode SDK.

    rm -rf build
    mkdir build
    cd build
    cmake -G Ninja \
        -D CMAKE_VERBOSE_MAKEFILE=on \
        -D OPENSSL_ROOT_DIR=/path/openssl/root \
        -D CMAKE_INSTALL_PREFIX=. \
        ..
    cmake --build . --target install
