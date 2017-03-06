#!/bin/zsh

git clone https://github.com/opencv/opencv.git /usr/src/opencv
git clone https://github.com/opencv/opencv_contrib.git /usr/src/opencv_contrib

mkdir /usr/src/opencv/build
cd /usr/src/opencv/build

CXX=/usr/bin/g++-5 GCC=/usr/bin/gcc-5 CC=/usr/bin/gcc-5 sudo cmake -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_PNG=OFF -DBUILD_opencv_dnn=OFF -DWITH_FFMPEG=OFF -DWITH_CUDA=OFF -DWITH_IPP=OFF -DENABLE_PRECOMPILED_HEADERS=OFF -DOPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules ..
make -j$(nproc)
make install