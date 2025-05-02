#!/bin/bash

set -ex

pushd "$(dirname $0)" >/dev/null
    SOURCE_DIR=$(pwd)
popd >/dev/null

BUILD_DIR=${SOURCE_DIR}/builddir
INSTALL_DIR=${SOURCE_DIR}/dist

rm -rf "${BUILD_DIR}" "${INSTALL_DIR}"
mkdir -p "${BUILD_DIR}"
pushd "${BUILD_DIR}" >/dev/null

cmake \
    -G Ninja \
    -D CMAKE_VERBOSE_MAKEFILE=on \
    -D CMAKE_INSTALL_PREFIX=${INSTALL_DIR} \
    ${SOURCE_DIR}
cmake --build .
cmake --build . --target install

popd >/dev/null

