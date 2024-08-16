#!/bin/bash

unset LD

if [[ "$target_platform" == "linux-"* ]]; then
  export CC=${GCC}
  export CXX=${GXX}
fi

./configure --prefix=$PREFIX --disable-static --disable-doc
[[ "$target_platform" == "win-64" ]] && patch_libtool
make -j$CPU_COUNT
make install

if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR}" != "" ]]; then
  make check
fi
