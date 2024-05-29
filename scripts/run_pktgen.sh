#!/bin/bash

PCIMEM_EXE=pcimem/pcimem

sudo dpdk-devbind.py -u 5e:00.0;
sudo dpdk-devbind.py -u 5e:00.1;

sudo /usr/bin/setpci -s 5e:00.0 COMMAND=0x02;
sudo /usr/bin/setpci -s 5e:00.1 COMMAND=0x02;

# setting
sudo $PCIMEM_EXE /sys/devices/pci0000:5d/0000:5d:00.0/0000:5e:00.0/resource2 0x1000 w 0x1;
sudo $PCIMEM_EXE /sys/devices/pci0000:5d/0000:5d:00.0/0000:5e:00.0/resource2 0x2000 w 0x00010001;

sudo $PCIMEM_EXE /sys/devices/pci0000:5d/0000:5d:00.0/0000:5e:00.0/resource2 0x8014 w 0x1;
sudo $PCIMEM_EXE /sys/devices/pci0000:5d/0000:5d:00.0/0000:5e:00.0/resource2 0x800c w 0x1;

sudo $PCIMEM_EXE /sys/devices/pci0000:5d/0000:5d:00.0/0000:5e:00.0/resource2 0xC014 w 0x1;
sudo $PCIMEM_EXE /sys/devices/pci0000:5d/0000:5d:00.0/0000:5e:00.0/resource2 0xC00c w 0x1;

sudo dpdk-devbind.py -b vfio-pci 5e:00.0;
sudo dpdk-devbind.py -b vfio-pci 5e:00.1;

sudo ../pktgen-dpdk/usr/local/bin/pktgen -a 5e:00.0 -a 5e:00.1 -d librte_net_qdma.so -l 16,18,20,22,24,26 -n 4 -a 5d:00.0 -a 5d:00.0 -- -m [20:22].0 -m [24:26].1
