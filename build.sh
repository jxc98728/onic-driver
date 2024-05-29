#!/bin/bash

cd dpdk-20.11
meson build
cd build
ninja
sudo ninja install
ls -l /usr/local/lib/x86_64-linux-gnu/librte_net_qdma.so
sudo ldconfig
ls -l ./app/test/dpdk-test
cd ../..
cd pktgen-dpdk
make RTE_SDK=../dpdk-20.11 RTE_TARGET=build
cd ../scripts/pcimem
make
