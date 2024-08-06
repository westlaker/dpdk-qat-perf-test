# from https://fast.dpdk.org/doc/perf/DPDK_23_03_Intel_crypto_performance_report.pdf
# TEST CASE : cryptodev-qat-pmd-aes-cbc128-sha1-hmac 
#PDK_TEST_CRYPTO_PERF=/home/ubuntu/dpdk-stable-21.11.4/build/app/
DPDK_TEST_CRYPTO_PERF=/home/ubuntu/dpdk-stable-21.11.4/build/x86_64-native-linuxapp-gcc/app/
DPDK_TEST_CRYPTO_PERF=/home/ubuntu/dpdk/build/app
#QAT_PF0=000c:03:01
#QAT_PF1=000c:04:01
#QAT_PF2=000c:05:01
QAT_PF0=0000:c5:01
QAT_PF1=0000:c6:01
QAT_PF2=0000:c7:01
# Intel 8480 QAT Engine
QAT_PF0=6b:00
QAT_PF1=6b:01
QAT_PF2=e8:00
QAT_PF3=e8:01

# results published by Intel
#Buffer Size (Bytes) AES-CBC-128/SHA1-HMAC (Gbps) AES-CBC-128/SHA2-256-HMAC (Gbps) AES-GCM-128 (Gbps)
#64 		     9.50 			  9.39 				   8.27
#128 		     18.70 			  18.54 			   16.40
#256 		     35.89 			  35.58 			   31.73
#512 		     63.24 			  62.71 			   57.50
#1024 		     85.45 			  83.37 			   79.97
#2048 		     91.70 			  92.47 			   91.85

CORE_OPTION="-l 9,10,60,11,61,12,62 -n 6"
CORE_OPTION="-l 4,5,13,6,14,7,15 -n 6"
CORE_OPTION="-l 4,6,8,10,12,14 -n 6"

# intel_pstate=disable console=ttyS0,115200n8 kpti=off default_hugepagesz=1G hugepagesz=1G hugepages=64 isolcpus=1-69 nohz_full=1-69 irqaffinity=0 rcu_nocbs=1-69 rcu_nocb_poll nosoftlockup intel_iommu=on iommu.passthrough=1 transparent_hugepage=always
# sudo sysctl -w vm.nr_hugepages=64
# /home/ubuntu/dpdk/usertools/dpdk-devbind.py -s
#
# Crypto devices using DPDK-compatible driver
# ===========================================
# QAT_PF0
# 0000:6b:00.1 'Device 4941' drv=vfio-pci unused=
# 0000:6b:00.2 'Device 4941' drv=vfio-pci unused=
# 0000:6b:00.3 'Device 4941' drv=vfio-pci unused=
# 0000:6b:00.4 'Device 4941' drv=vfio-pci unused=
# 0000:6b:00.5 'Device 4941' drv=vfio-pci unused=
# 0000:6b:00.6 'Device 4941' drv=vfio-pci unused=
# 0000:6b:00.7 'Device 4941' drv=vfio-pci unused=
# QAT_PF1
# 0000:6b:01.0 'Device 4941' drv=vfio-pci unused=
# 0000:6b:01.1 'Device 4941' drv=vfio-pci unused=
# 0000:6b:01.2 'Device 4941' drv=vfio-pci unused=
# 0000:6b:01.3 'Device 4941' drv=vfio-pci unused=
# 0000:6b:01.4 'Device 4941' drv=vfio-pci unused=
# 0000:6b:01.5 'Device 4941' drv=vfio-pci unused=
# 0000:6b:01.6 'Device 4941' drv=vfio-pci unused=
# 0000:6b:01.7 'Device 4941' drv=vfio-pci unused=
# 0000:6b:02.0 'Device 4941' drv=vfio-pci unused=
# QAT_PF2
# 0000:e8:00.1 'Device 4941' drv=vfio-pci unused=
# 0000:e8:00.2 'Device 4941' drv=vfio-pci unused=
# 0000:e8:00.3 'Device 4941' drv=vfio-pci unused=
# 0000:e8:00.4 'Device 4941' drv=vfio-pci unused=
# 0000:e8:00.5 'Device 4941' drv=vfio-pci unused=
# 0000:e8:00.6 'Device 4941' drv=vfio-pci unused=
# 0000:e8:00.7 'Device 4941' drv=vfio-pci unused=
# QAT_PF3
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

case $1 in
	0)
		echo "crypto_scheduler aes-cbc/sha1-hmac intel-cryptodev-crypto-scheduler-tests.sh 0"
		COMMAND="sudo ${DPDK_TEST_CRYPTO_PERF}/dpdk-test-crypto-perf \
                --socket-mem 2048,0 --legacy-mem \
                -a ${QAT_PF0}.1 -a ${QAT_PF0}.6 -a ${QAT_PF1}.3 \
                -a ${QAT_PF0}.2 -a ${QAT_PF0}.7 -a ${QAT_PF1}.4 \
                -a ${QAT_PF0}.3 -a ${QAT_PF1}.0 -a ${QAT_PF1}.5 \
                -a ${QAT_PF0}.4 -a ${QAT_PF1}.1 -a ${QAT_PF1}.6 \
                -a ${QAT_PF0}.5 -a ${QAT_PF1}.2 -a ${QAT_PF1}.7 \
                --vdev crypto_scheduler_pmd_1,worker=${QAT_PF0}.1_qat_sym,worker=${QAT_PF1}.1_qat_sym,worker=${QAT_PF0}.6_qat_sym,mode=round-robin \
                --vdev crypto_scheduler_pmd_2,worker=${QAT_PF0}.2_qat_sym,worker=${QAT_PF1}.2_qat_sym,worker=${QAT_PF0}.7_qat_sym,mode=round-robin \
                --vdev crypto_scheduler_pmd_3,worker=${QAT_PF0}.3_qat_sym,worker=${QAT_PF1}.3_qat_sym,worker=${QAT_PF1}.0_qat_sym,mode=round-robin \
                --vdev crypto_scheduler_pmd_4,worker=${QAT_PF0}.4_qat_sym,worker=${QAT_PF1}.4_qat_sym,worker=${QAT_PF1}.6_qat_sym,mode=round-robin \
                --vdev crypto_scheduler_pmd_5,worker=${QAT_PF0}.5_qat_sym,worker=${QAT_PF1}.5_qat_sym,worker=${QAT_PF1}.7_qat_sym,mode=round-robin \
		${CORE_OPTION} \
                -- --buffer-sz 64,128,256,512,1024,2048 --optype cipher-then-auth --ptest throughput \
                --auth-key-sz 64 --cipher-key-sz 16 --devtype crypto_scheduler --cipher-iv-sz 16 \
                --auth-op generate --burst-sz 32 --total-ops 30000000 --digest-sz 20 \
                --auth-algo sha1-hmac --cipher-algo aes-cbc --cipher-op encrypt"

		sudo $COMMAND

#		sudo ${DPDK_TEST_CRYPTO_PERF}/dpdk-test-crypto-perf \
#		--socket-mem 2048,0 --legacy-mem \
#		-a ${QAT_PF0}.0 -a ${QAT_PF1}.0 -a ${QAT_PF2}.0 \
#		-a ${QAT_PF0}.1 -a ${QAT_PF1}.1 -a ${QAT_PF2}.1 \
#		-a ${QAT_PF0}.2 -a ${QAT_PF1}.2 -a ${QAT_PF2}.2 \
#		-a ${QAT_PF0}.3 -a ${QAT_PF1}.3 -a ${QAT_PF2}.3 \
#		-a ${QAT_PF0}.4 -a ${QAT_PF1}.4 -a ${QAT_PF2}.4 \
#		-a ${QAT_PF0}.5 -a ${QAT_PF1}.5 -a ${QAT_PF2}.5 \
#		--vdev crypto_scheduler_pmd_1,worker=${QAT_PF0}.0_qat_sym,worker=${QAT_PF1}.0_qat_sym,worker=${QAT_PF2}.0_qat_sym,mode=round-robin \
#		--vdev crypto_scheduler_pmd_2,worker=${QAT_PF0}.1_qat_sym,worker=${QAT_PF1}.1_qat_sym,worker=${QAT_PF2}.1_qat_sym,mode=round-robin \
#		--vdev crypto_scheduler_pmd_3,worker=${QAT_PF0}.2_qat_sym,worker=${QAT_PF1}.2_qat_sym,worker=${QAT_PF2}.2_qat_sym,mode=round-robin \
#		--vdev crypto_scheduler_pmd_4,worker=${QAT_PF0}.3_qat_sym,worker=${QAT_PF1}.3_qat_sym,worker=${QAT_PF2}.3_qat_sym,mode=round-robin \
#		--vdev crypto_scheduler_pmd_5,worker=${QAT_PF0}.4_qat_sym,worker=${QAT_PF1}.4_qat_sym,worker=${QAT_PF2}.4_qat_sym,mode=round-robin \
#		--vdev crypto_scheduler_pmd_6,worker=${QAT_PF0}.5_qat_sym,worker=${QAT_PF1}.5_qat_sym,worker=${QAT_PF2}.5_qat_sym,mode=round-robin \
#		${CORE_OPTION} \
#		-- --buffer-sz 64,128,256,512,1024,2048 --optype cipher-then-auth --ptest throughput \
#		--auth-key-sz 64 --cipher-key-sz 16 --devtype crypto_scheduler --cipher-iv-sz 16 \
#		--auth-op generate --burst-sz 32 --total-ops 30000000 --digest-sz 20 \
#		--auth-algo sha1-hmac --cipher-algo aes-cbc --cipher-op encrypt
		;;
	1)
		echo "crypto_scheduler aes-cbc/sha2-256-hmac intel-cryptodev-crypto-scheduler-tests.sh 1"
		echo "sudo ${DPDK_TEST_CRYPTO_PERF}/dpdk-test-crypto-perf \
                --socket-mem 2048,0 --legacy-mem \
                -a ${QAT_PF0}.0 -a ${QAT_PF1}.0 -a ${QAT_PF2}.0 \
                -a ${QAT_PF0}.1 -a ${QAT_PF1}.1 -a ${QAT_PF2}.1 \
                -a ${QAT_PF0}.2 -a ${QAT_PF1}.2 -a ${QAT_PF2}.2 \
                -a ${QAT_PF0}.3 -a ${QAT_PF1}.3 -a ${QAT_PF2}.3 \
                -a ${QAT_PF0}.4 -a ${QAT_PF1}.4 -a ${QAT_PF2}.4 \
                -a ${QAT_PF0}.5 -a ${QAT_PF1}.5 -a ${QAT_PF2}.5 \
                --vdev crypto_scheduler_pmd_1,worker=${QAT_PF0}.0_qat_sym,worker=${QAT_PF1}.0_qat_sym,worker=${QAT_PF2}.0_qat_sym,mode=round-robin \
                --vdev crypto_scheduler_pmd_2,worker=${QAT_PF0}.1_qat_sym,worker=${QAT_PF1}.1_qat_sym,worker=${QAT_PF2}.1_qat_sym,mode=round-robin \
                --vdev crypto_scheduler_pmd_3,worker=${QAT_PF0}.2_qat_sym,worker=${QAT_PF1}.2_qat_sym,worker=${QAT_PF2}.2_qat_sym,mode=round-robin \
                --vdev crypto_scheduler_pmd_4,worker=${QAT_PF0}.3_qat_sym,worker=${QAT_PF1}.3_qat_sym,worker=${QAT_PF2}.3_qat_sym,mode=round-robin \
                --vdev crypto_scheduler_pmd_5,worker=${QAT_PF0}.4_qat_sym,worker=${QAT_PF1}.4_qat_sym,worker=${QAT_PF2}.4_qat_sym,mode=round-robin \
                --vdev crypto_scheduler_pmd_6,worker=${QAT_PF0}.5_qat_sym,worker=${QAT_PF1}.5_qat_sym,worker=${QAT_PF2}.5_qat_sym,mode=round-robin \
		${CORE_OPTION} \
                -- --buffer-sz 64,128,256,512,1024,2048 --optype cipher-then-auth --ptest throughput \
                --auth-key-sz 64 --cipher-key-sz 16 --devtype crypto_scheduler \
                --cipher-iv-sz 16 --auth-op generate --burst-sz 32 \
                --total-ops 30000000 --digest-sz 32 --auth-algo sha2-256-hmac --cipher-algo aes-cbc --cipher-op encrypt"

		sudo ${DPDK_TEST_CRYPTO_PERF}/dpdk-test-crypto-perf \
		--socket-mem 2048,0 --legacy-mem \
		-a ${QAT_PF0}.0 -a ${QAT_PF1}.0 -a ${QAT_PF2}.0 \
		-a ${QAT_PF0}.1 -a ${QAT_PF1}.1 -a ${QAT_PF2}.1 \
		-a ${QAT_PF0}.2 -a ${QAT_PF1}.2 -a ${QAT_PF2}.2 \
		-a ${QAT_PF0}.3 -a ${QAT_PF1}.3 -a ${QAT_PF2}.3 \
		-a ${QAT_PF0}.4 -a ${QAT_PF1}.4 -a ${QAT_PF2}.4 \
		-a ${QAT_PF0}.5 -a ${QAT_PF1}.5 -a ${QAT_PF2}.5 \
		--vdev crypto_scheduler_pmd_1,worker=${QAT_PF0}.0_qat_sym,worker=${QAT_PF1}.0_qat_sym,worker=${QAT_PF2}.0_qat_sym,mode=round-robin \
		--vdev crypto_scheduler_pmd_2,worker=${QAT_PF0}.1_qat_sym,worker=${QAT_PF1}.1_qat_sym,worker=${QAT_PF2}.1_qat_sym,mode=round-robin \
		--vdev crypto_scheduler_pmd_3,worker=${QAT_PF0}.2_qat_sym,worker=${QAT_PF1}.2_qat_sym,worker=${QAT_PF2}.2_qat_sym,mode=round-robin \
		--vdev crypto_scheduler_pmd_4,worker=${QAT_PF0}.3_qat_sym,worker=${QAT_PF1}.3_qat_sym,worker=${QAT_PF2}.3_qat_sym,mode=round-robin \
		--vdev crypto_scheduler_pmd_5,worker=${QAT_PF0}.4_qat_sym,worker=${QAT_PF1}.4_qat_sym,worker=${QAT_PF2}.4_qat_sym,mode=round-robin \
		--vdev crypto_scheduler_pmd_6,worker=${QAT_PF0}.5_qat_sym,worker=${QAT_PF1}.5_qat_sym,worker=${QAT_PF2}.5_qat_sym,mode=round-robin \
		${CORE_OPTION} \
		-- --buffer-sz 64,128,256,512,1024,2048 --optype cipher-then-auth --ptest throughput \
		--auth-key-sz 64 --cipher-key-sz 16 --devtype crypto_scheduler \
		--cipher-iv-sz 16 --auth-op generate --burst-sz 32 \
		--total-ops 30000000 --digest-sz 32 --auth-algo sha2-256-hmac --cipher-algo aes-cbc --cipher-op encrypt
		;;
	2)
		echo "crypto_scheduler aes-gcm intel-cryptodev-crypto-scheduler-tests.sh 2"
		echo "sudo ${DPDK_TEST_CRYPTO_PERF}/dpdk-test-crypto-perf \
		--socket-mem 2048,0 --legacy-mem \
		-a ${QAT_PF0}.0 -a ${QAT_PF1}.0 -a ${QAT_PF2}.0 \
		-a ${QAT_PF0}.1 -a ${QAT_PF1}.1 -a ${QAT_PF2}.1 \
		-a ${QAT_PF0}.2 -a ${QAT_PF1}.2 -a ${QAT_PF2}.2 \
		-a ${QAT_PF0}.3 -a ${QAT_PF1}.3 -a ${QAT_PF2}.3 \
		-a ${QAT_PF0}.4 -a ${QAT_PF1}.4 -a ${QAT_PF2}.4 \
		-a ${QAT_PF0}.5 -a ${QAT_PF1}.5 -a ${QAT_PF2}.5 \
		--vdev crypto_scheduler_pmd_1,worker=${QAT_PF0}.0_qat_sym,worker=${QAT_PF1}.0_qat_sym,worker=${QAT_PF2}.0_qat_sym,mode=round-robin \
		--vdev crypto_scheduler_pmd_2,worker=${QAT_PF0}.1_qat_sym,worker=${QAT_PF1}.1_qat_sym,worker=${QAT_PF2}.1_qat_sym,mode=round-robin \
		--vdev crypto_scheduler_pmd_3,worker=${QAT_PF0}.2_qat_sym,worker=${QAT_PF1}.2_qat_sym,worker=${QAT_PF2}.2_qat_sym,mode=round-robin \
		--vdev crypto_scheduler_pmd_4,worker=${QAT_PF0}.3_qat_sym,worker=${QAT_PF1}.3_qat_sym,worker=${QAT_PF2}.3_qat_sym,mode=round-robin \
		--vdev crypto_scheduler_pmd_5,worker=${QAT_PF0}.4_qat_sym,worker=${QAT_PF1}.4_qat_sym,worker=${QAT_PF2}.4_qat_sym,mode=round-robin \
		--vdev crypto_scheduler_pmd_6,worker=${QAT_PF0}.5_qat_sym,worker=${QAT_PF1}.5_qat_sym,worker=${QAT_PF2}.5_qat_sym,mode=round-robin \
		${CORE_OPTION} \
		-- --aead-key-sz 16 --buffer-sz 64,128,256,512,1024,2048 \
		--optype aead --ptest throughput --aead-aad-sz 16 \
		--devtype crypto_scheduler --aead-op encrypt --burst-sz 32 --total-ops 30000000 \
		--digest-sz 16 --aead-algo aes-gcm --aead-iv-sz 12"

		sudo ${DPDK_TEST_CRYPTO_PERF}/dpdk-test-crypto-perf \
		--socket-mem 2048,0 --legacy-mem \
		-a ${QAT_PF0}.0 -a ${QAT_PF1}.0 -a ${QAT_PF2}.0 \
		-a ${QAT_PF0}.1 -a ${QAT_PF1}.1 -a ${QAT_PF2}.1 \
		-a ${QAT_PF0}.2 -a ${QAT_PF1}.2 -a ${QAT_PF2}.2 \
		-a ${QAT_PF0}.3 -a ${QAT_PF1}.3 -a ${QAT_PF2}.3 \
		-a ${QAT_PF0}.4 -a ${QAT_PF1}.4 -a ${QAT_PF2}.4 \
		-a ${QAT_PF0}.5 -a ${QAT_PF1}.5 -a ${QAT_PF2}.5 \
		--vdev crypto_scheduler_pmd_1,worker=${QAT_PF0}.0_qat_sym,worker=${QAT_PF1}.0_qat_sym,worker=${QAT_PF2}.0_qat_sym,mode=round-robin \
		--vdev crypto_scheduler_pmd_2,worker=${QAT_PF0}.1_qat_sym,worker=${QAT_PF1}.1_qat_sym,worker=${QAT_PF2}.1_qat_sym,mode=round-robin \
		--vdev crypto_scheduler_pmd_3,worker=${QAT_PF0}.2_qat_sym,worker=${QAT_PF1}.2_qat_sym,worker=${QAT_PF2}.2_qat_sym,mode=round-robin \
		--vdev crypto_scheduler_pmd_4,worker=${QAT_PF0}.3_qat_sym,worker=${QAT_PF1}.3_qat_sym,worker=${QAT_PF2}.3_qat_sym,mode=round-robin \
		--vdev crypto_scheduler_pmd_5,worker=${QAT_PF0}.4_qat_sym,worker=${QAT_PF1}.4_qat_sym,worker=${QAT_PF2}.4_qat_sym,mode=round-robin \
		--vdev crypto_scheduler_pmd_6,worker=${QAT_PF0}.5_qat_sym,worker=${QAT_PF1}.5_qat_sym,worker=${QAT_PF2}.5_qat_sym,mode=round-robin \
		${CORE_OPTION} \
		-- --aead-key-sz 16 --buffer-sz 64,128,256,512,1024,2048 \
		--optype aead --ptest throughput --aead-aad-sz 16 \
		--devtype crypto_scheduler --aead-op encrypt --burst-sz 32 --total-ops 30000000 \
		--digest-sz 16 --aead-algo aes-gcm --aead-iv-sz 12
		;;
esac
