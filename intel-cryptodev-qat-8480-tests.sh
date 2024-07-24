#!/usr/bin/bash
#DPDK_TEST_CRYPTO_PERF=/home/ubuntu/dpdk-stable-21.11.4/build/app/
#DPDK_TEST_CRYPTO_PERF=/home/ubuntu/dpdk-stable-21.11.4/build/x86_64-native-linuxapp-gcc/app/
DPDK_TEST_CRYPTO_PERF=/home/ubuntu/dpdk/build/app
#QAT_PF0=0000:c5:01
#QAT_PF1=0000:c6:01
#QAT_PF2=0000:c7:01
#QAT_PF0=000c:03:01
#QAT_PF1=000c:04:01
#QAT_PF2=000c:05:01
# Intel 8480 QAT Engine
QAT_PF0=6b:00
QAT_PF1=6b:01

# results published by Intel
#Buffer Size (Bytes) AES-CBC-128/SHA1-HMAC (Gbps) AES-CBC-128/SHA2-256-HMAC (Gbps) AES-GCM-128 (Gbps)
#64 		     3.90 			  3.89 				   3.35
#128 		     7.72 			  7.68 				   6.66
#256 		     15.06 			  14.92 			   13.10 
#512 		     28.31 			  27.99 			   24.69
#1024 		     45.60 			  46.67 			   39.58
#2048 		     52.70 			  52.45 			   49.85

# intel_pstate=disable console=ttyS0,115200n8 kpti=off default_hugepagesz=1G hugepagesz=1G hugepages=64 isolcpus=1-69 nohz_full=1-69 irqaffinity=0 rcu_nocbs=1-69 rcu_nocb_poll nosoftlockup intel_iommu=on iommu.passthrough=1 transparent_hugepage=always
# sudo sysctl -w vm.nr_hugepages=64
# /home/ubuntu/dpdk/usertools/dpdk-devbind.py -s
#
# Crypto devices using DPDK-compatible driver
# ===========================================
# 0000:6b:00.1 'Device 4941' drv=vfio-pci unused=
# 0000:6b:00.2 'Device 4941' drv=vfio-pci unused=
# 0000:6b:00.3 'Device 4941' drv=vfio-pci unused=
# 0000:6b:00.4 'Device 4941' drv=vfio-pci unused=
# 0000:6b:00.5 'Device 4941' drv=vfio-pci unused=
# 0000:6b:00.6 'Device 4941' drv=vfio-pci unused=
# 0000:6b:00.7 'Device 4941' drv=vfio-pci unused=
# 0000:6b:01.0 'Device 4941' drv=vfio-pci unused=
# 0000:6b:01.1 'Device 4941' drv=vfio-pci unused=
# 0000:6b:01.2 'Device 4941' drv=vfio-pci unused=
# 0000:6b:01.3 'Device 4941' drv=vfio-pci unused=
# 0000:6b:01.4 'Device 4941' drv=vfio-pci unused=
# 0000:6b:01.5 'Device 4941' drv=vfio-pci unused=
# 0000:6b:01.6 'Device 4941' drv=vfio-pci unused=
# 0000:6b:01.7 'Device 4941' drv=vfio-pci unused=
# 0000:6b:02.0 'Device 4941' drv=vfio-pci unused=
# 0000:e8:00.1 'Device 4941' drv=vfio-pci unused=
# 0000:e8:00.2 'Device 4941' drv=vfio-pci unused=
# 0000:e8:00.3 'Device 4941' drv=vfio-pci unused=
# 0000:e8:00.4 'Device 4941' drv=vfio-pci unused=
# 0000:e8:00.5 'Device 4941' drv=vfio-pci unused=
# 0000:e8:00.6 'Device 4941' drv=vfio-pci unused=
# 0000:e8:00.7 'Device 4941' drv=vfio-pci unused=
# 0000:e8:01.0 'Device 4941' drv=vfio-pci unused=
# 0000:e8:01.1 'Device 4941' drv=vfio-pci unused=
# 0000:e8:01.2 'Device 4941' drv=vfio-pci unused=
# 0000:e8:01.3 'Device 4941' drv=vfio-pci unused=
# 0000:e8:01.4 'Device 4941' drv=vfio-pci unused=
# 0000:e8:01.5 'Device 4941' drv=vfio-pci unused=
# 0000:e8:01.6 'Device 4941' drv=vfio-pci unused=
# 0000:e8:01.7 'Device 4941' drv=vfio-pci unused=
# 0000:e8:02.0 'Device 4941' drv=vfio-pci unused=

# Crypto devices using kernel driver
# ==================================
# 0000:6b:00.0 'Device 4940' drv=4xxx unused=qat_4xxx,vfio-pci 
# 0000:e8:00.0 'Device 4940' drv=4xxx unused=qat_4xxx,vfio-pci 

#		-a ${QAT_PF0}.0  -a ${QAT_PF0}.1 -a ${QAT_PF0}.2 -a ${QAT_PF0}.3 \
#		-l 4,5,13,6,14 -n 4 \
case $1 in
	0)
		echo "(AES-CBC128/SHA1-HMAC)"
		echo "sudo $DPDK_TEST_CRYPTO_PERF/dpdk-test-crypto-perf \
                --socket-mem 2048,0 --legacy-mem \
                -a ${QAT_PF0}.1  -a ${QAT_PF0}.2 -a ${QAT_PF0}.3 -a ${QAT_PF0}.4 \
                -a ${QAT_PF0}.5  -a ${QAT_PF0}.6 -a ${QAT_PF0}.7 -a ${QAT_PF1}.0 \
		-a ${QAT_PF1}.1  -a ${QAT_PF1}.2 \
		-l 2,4,6,8,10,12,14,16,18,20,22 -n 10 \
                -- --buffer-sz 64,128,256,512,1024,2048 \
                --optype cipher-then-auth --ptest throughput --auth-key-sz 64 --cipher-key-sz 16 \
                --devtype crypto_qat --cipher-iv-sz 16 --auth-op generate --burst-sz 32 \
                --total-ops 30000000 --digest-sz 20 --auth-algo sha1-hmac --cipher-algo aes-cbc --cipher-op encrypt"

		sudo $DPDK_TEST_CRYPTO_PERF/dpdk-test-crypto-perf \
		--socket-mem 2048,0 --legacy-mem \
		--log-level 5 \
                -a ${QAT_PF0}.1  -a ${QAT_PF0}.2 -a ${QAT_PF0}.3 -a ${QAT_PF0}.4 \
                -a ${QAT_PF0}.5  -a ${QAT_PF0}.6 -a ${QAT_PF0}.7 -a ${QAT_PF1}.0 \
		-a ${QAT_PF1}.1  -a ${QAT_PF1}.2 \
		-l 2,4,6,8,10,12,14,16,18,20,22 -n 10 \
                -- --buffer-sz 64,128,256,512,1024,2048 \
                --optype cipher-then-auth --ptest throughput --auth-key-sz 64 --cipher-key-sz 16 \
                --devtype crypto_qat --cipher-iv-sz 16 --auth-op generate --burst-sz 32 \
                --total-ops 30000000 --digest-sz 20 --auth-algo sha1-hmac --cipher-algo aes-cbc --cipher-op encrypt
		;;
	1)
		echo "(AES-CBC128/SHA2-256-HMAC)"
		echo "sudo $DPDK_TEST_CRYPTO_PERF/dpdk-test-crypto-perf \
                --socket-mem 2048,0 --legacy-mem \
                -a ${QAT_PF0}.1  -a ${QAT_PF0}.2 -a ${QAT_PF0}.3 -a ${QAT_PF0}.4 \
                -a ${QAT_PF0}.5  -a ${QAT_PF0}.6 -a ${QAT_PF0}.7 -a ${QAT_PF1}.0 \
		-a ${QAT_PF1}.1  -a ${QAT_PF1}.2 \
		-l 2,4,6,8,10,12,14,16,18,20,22 -n 10 \
                -- --buffer-sz 64,128,256,512,1024,2048 \
                --optype cipher-then-auth --ptest throughput --auth-key-sz 64 --cipher-key-sz 16 \
                --devtype crypto_qat --cipher-iv-sz 16 --auth-op generate --burst-sz 32 \
                --total-ops 30000000 --digest-sz 20 --auth-algo sha2-256-hmac --cipher-algo aes-cbc --cipher-op encrypt"

		sudo $DPDK_TEST_CRYPTO_PERF/dpdk-test-crypto-perf \
		--socket-mem 2048,0 --legacy-mem \
                -a ${QAT_PF0}.1  -a ${QAT_PF0}.2 -a ${QAT_PF0}.3 -a ${QAT_PF0}.4 \
                -a ${QAT_PF0}.5  -a ${QAT_PF0}.6 -a ${QAT_PF0}.7 -a ${QAT_PF1}.0 \
		-a ${QAT_PF1}.1  -a ${QAT_PF1}.2 \
		-l 2,4,6,8,10,12,14,16,18,20,22 -n 10 \
		-- --buffer-sz 64,128,256,512,1024,2048 \
		--optype cipher-then-auth --ptest throughput --auth-key-sz 64 --cipher-key-sz 16 \
		--devtype crypto_qat --cipher-iv-sz 16 --auth-op generate --burst-sz 32 \
		--total-ops 30000000 --digest-sz 20 --auth-algo sha2-256-hmac --cipher-algo aes-cbc --cipher-op encrypt
		;;
	2)
		echo "(AES-GCM-128)"
		echo "sudo $DPDK_TEST_CRYPTO_PERF/dpdk-test-crypto-perf \
                --socket-mem 2048,0 --legacy-mem \
                -a ${QAT_PF0}.1  -a ${QAT_PF0}.2 -a ${QAT_PF0}.3 -a ${QAT_PF0}.4 \
                -a ${QAT_PF0}.5  -a ${QAT_PF0}.6 -a ${QAT_PF0}.7 -a ${QAT_PF1}.0 \
		-a ${QAT_PF1}.1  -a ${QAT_PF1}.2 \
		-l 2,4,6,8,10,12,14,16,18,20,22 -n 10 \
                -- --buffer-sz 64,128,256,512,1024,2048 \
                --aead-key-sz 16 --optype aead --ptest throughput --aead-aad-sz 16 --devtype crypto_qat --aead-op encrypt \
                --burst-sz 32 --total-ops 30000000 --digest-sz 16 --aead-algo aes-gcm --aead-iv-sz 12"

		sudo $DPDK_TEST_CRYPTO_PERF/dpdk-test-crypto-perf \
		--socket-mem 2048,0 --legacy-mem \
                -a ${QAT_PF0}.1  -a ${QAT_PF0}.2 -a ${QAT_PF0}.3 -a ${QAT_PF0}.4 \
                -a ${QAT_PF0}.5  -a ${QAT_PF0}.6 -a ${QAT_PF0}.7 -a ${QAT_PF1}.0 \
		-a ${QAT_PF1}.1  -a ${QAT_PF1}.2 \
		-l 2,4,6,8,10,12,14,16,18,20,22 -n 10 \
		-- --buffer-sz 64,128,256,512,1024,2048 \
		--aead-key-sz 16 --optype aead --ptest throughput --aead-aad-sz 16 --devtype crypto_qat --aead-op encrypt \
		--burst-sz 32 --total-ops 30000000 --digest-sz 16 --aead-algo aes-gcm --aead-iv-sz 12
		;;
esac
