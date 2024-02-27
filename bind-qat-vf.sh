#!/bin/sh
DEVBIND_PATH=/home/ubuntu/dpdk-stable-21.11.4/usertools/dpdk-devbind.py
for device in 5 6 7; do \
  for fn in $(seq 0 7); do \
    sudo ${DEVBIND_PATH} --bind=vfio-pci c${device}:01.${fn}; \
    sudo ${DEVBIND_PATH} --bind=vfio-pci c${device}:02.${fn}; \
    echo 0000:c${device}:01.${fn} 0000:c${device}:02.${fn};
  done;
done
