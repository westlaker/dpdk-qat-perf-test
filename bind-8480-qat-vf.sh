#!/bin/sh
#DEVBIND_PATH=/home/ubuntu/dpdk-stable-21.11.4/usertools/dpdk-devbind.py
DEVBIND_PATH=/home/ubuntu/dpdk/usertools/dpdk-devbind.py
# intel
#for device in 5 6 7; do \
#   for fn in $(seq 0 7); do \
#    sudo ${DEVBIND_PATH} --bind=vfio-pci c${device}:01.${fn}; \
#    sudo ${DEVBIND_PATH} --bind=vfio-pci c${device}:02.${fn}; \
#    echo 0000:c${device}:01.${fn} 0000:c${device}:02.${fn};
#  done;
#done

# intel SPR Xeon 8480+
#for fn in $(seq 0 7); do \
#   sudo ${DEVBIND_PATH} --bind=vfio-pci 0000:6b:00.${fn}; \
#   sudo ${DEVBIND_PATH} --bind=vfio-pci 0000.e8:00.${fn}; \
#   echo 0000:6b:00.${fn} 0000.e8:00.${fn}
#done;


# arm
#for device in 3 4 5; do \
#  for fn in $(seq 0 7); do \
#    sudo ${DEVBIND_PATH} --bind=vfio-pci 000c:0${device}:01.${fn}; \
#    sudo ${DEVBIND_PATH} --bind=vfio-pci 000c:0${device}:02.${fn}; \
#    echo 000c:0${device}:01.${fn} 000c:0${device}:02.${fn};
#  done;
#done

# this is PF do not do it: sudo ${DEVBIND_PATH} --bind=vfio-pci 6b:00.0
sudo ${DEVBIND_PATH} --bind=vfio-pci 6b:00.1
sudo ${DEVBIND_PATH} --bind=vfio-pci 6b:00.2
sudo ${DEVBIND_PATH} --bind=vfio-pci 6b:00.3
sudo ${DEVBIND_PATH} --bind=vfio-pci 6b:00.4
sudo ${DEVBIND_PATH} --bind=vfio-pci 6b:00.5
sudo ${DEVBIND_PATH} --bind=vfio-pci 6b:00.6
sudo ${DEVBIND_PATH} --bind=vfio-pci 6b:00.7
sudo ${DEVBIND_PATH} --bind=vfio-pci 6b:01.0
sudo ${DEVBIND_PATH} --bind=vfio-pci 6b:01.1
sudo ${DEVBIND_PATH} --bind=vfio-pci 6b:01.2
sudo ${DEVBIND_PATH} --bind=vfio-pci 6b:01.3
sudo ${DEVBIND_PATH} --bind=vfio-pci 6b:01.4
sudo ${DEVBIND_PATH} --bind=vfio-pci 6b:01.5
sudo ${DEVBIND_PATH} --bind=vfio-pci 6b:01.6
sudo ${DEVBIND_PATH} --bind=vfio-pci 6b:01.7
sudo ${DEVBIND_PATH} --bind=vfio-pci 6b:02.0

# this is PF do not do it: sudo ${DEVBIND_PATH} --bind=vfio-pci e8:00.0
sudo ${DEVBIND_PATH} --bind=vfio-pci e8:00.1
sudo ${DEVBIND_PATH} --bind=vfio-pci e8:00.2
sudo ${DEVBIND_PATH} --bind=vfio-pci e8:00.3
sudo ${DEVBIND_PATH} --bind=vfio-pci e8:00.4
sudo ${DEVBIND_PATH} --bind=vfio-pci e8:00.5
sudo ${DEVBIND_PATH} --bind=vfio-pci e8:00.6
sudo ${DEVBIND_PATH} --bind=vfio-pci e8:00.7
sudo ${DEVBIND_PATH} --bind=vfio-pci e8:01.0
sudo ${DEVBIND_PATH} --bind=vfio-pci e8:01.1
sudo ${DEVBIND_PATH} --bind=vfio-pci e8:01.2
sudo ${DEVBIND_PATH} --bind=vfio-pci e8:01.3
sudo ${DEVBIND_PATH} --bind=vfio-pci e8:01.4
sudo ${DEVBIND_PATH} --bind=vfio-pci e8:01.5
sudo ${DEVBIND_PATH} --bind=vfio-pci e8:01.6
sudo ${DEVBIND_PATH} --bind=vfio-pci e8:01.7
sudo ${DEVBIND_PATH} --bind=vfio-pci e8:02.0
