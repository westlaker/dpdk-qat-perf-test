#!/usr/bin/bash
#DPDK_TEST_CRYPTO_PERF=/home/ubuntu/dpdk-stable-21.11.4/build/app/
DPDK_TEST_CRYPTO_PERF=/home/ubuntu/dpdk-stable-21.11.4/build/x86_64-native-linuxapp-gcc/app/
QAT_PF0=0000:c5:01
QAT_PF1=0000:c6:01
QAT_PF2=0000:c7:01
#QAT_PF0=000c:03:01
#QAT_PF1=000c:04:01
#QAT_PF2=000c:05:01

timestamp() {
    date +"%Y-%m-%d-%H-%M-%S"
}

LOG_FILE=test-crypto-qat-$(timestamp).txt

# results published by Intel
#Buffer Size (Bytes) AES-CBC-128/SHA1-HMAC (Gbps) AES-CBC-128/SHA2-256-HMAC (Gbps) AES-GCM-128 (Gbps)
#64 		     3.90 			  3.89 				   3.35
#128 		     7.72 			  7.68 				   6.66
#256 		     15.06 			  14.92 			   13.10 
#512 		     28.31 			  27.99 			   24.69
#1024 		     45.60 			  46.67 			   39.58
#2048 		     52.70 			  52.45 			   49.85

#-l 9,10,66,11,67,12,68 -n 6 \
CORE_OPTION="-l 9,10,60,11,61,12,62 -n 6"
CORE_OPTION="-l 4,5,13,6,14,7,15 -n 6"


case $1 in
	0)
		echo "(AES-CBC128/SHA1-HMAC)"
		echo "sudo $DPDK_TEST_CRYPTO_PERF/dpdk-test-crypto-perf \
                --socket-mem 2048,0 --legacy-mem \
                -a ${QAT_PF0}.0  -a ${QAT_PF0}.1 -a ${QAT_PF0}.2 -a ${QAT_PF0}.3 \
                -l 4,5,13,6,14 -n 4 \
                -- --buffer-sz 64,128,256,512,1024,2048 \
                --optype cipher-then-auth --ptest throughput --auth-key-sz 64 --cipherkey-sz 16 \
                --devtype crypto_qat --cipher-iv-sz 16 --auth-op generate --burst-sz 32 \
                --total-ops 30000000 --digest-sz 20 --auth-algo sha1-hmac --cipher-algo aes-cbc --cipher-op encrypt"

		sudo $DPDK_TEST_CRYPTO_PERF/dpdk-test-crypto-perf \
		--socket-mem 2048,0 --legacy-mem \
		-a ${QAT_PF0}.0  -a ${QAT_PF0}.1 -a ${QAT_PF0}.2 -a ${QAT_PF0}.3 \
		-l 4,5,13,6,14 -n 4 \
		-- --buffer-sz 64,128,256,512,1024,2048 \
		--optype cipher-then-auth --ptest throughput --auth-key-sz 64 --cipher-key-sz 16 \
		--devtype crypto_qat --cipher-iv-sz 16 --auth-op generate --burst-sz 32 \
		--total-ops 30000000 --digest-sz 20 --auth-algo sha1-hmac --cipher-algo aes-cbc --cipher-op encrypt
		;;
	1)
		echo "(AES-CBC128/SHA2-256-HMAC)"
		echo "sudo $DPDK_TEST_CRYPTO_PERF/dpdk-test-crypto-perf \
                --socket-mem 2048,0 --legacy-mem \
                -a ${QAT_PF0}.0  -a ${QAT_PF0}.1 -a ${QAT_PF0}.2 -a ${QAT_PF0}.3 \
                -l 4,5,13,6,14 -n 4 \
                -- --buffer-sz 64,128,256,512,1024,2048 \
                --optype cipher-then-auth --ptest throughput --auth-key-sz 64 --cipher-key-sz 16 \
                --devtype crypto_qat --cipher-iv-sz 16 --auth-op generate --burst-sz 32 \
                --total-ops 30000000 --digest-sz 20 --auth-algo sha2-256-hmac --cipher-algo aes-cbc --cipher-op encrypt"

		sudo $DPDK_TEST_CRYPTO_PERF/dpdk-test-crypto-perf \
		--socket-mem 2048,0 --legacy-mem \
		-a ${QAT_PF0}.0  -a ${QAT_PF0}.1 -a ${QAT_PF0}.2 -a ${QAT_PF0}.3 \
		-l 4,5,13,6,14 -n 4 \
		-- --buffer-sz 64,128,256,512,1024,2048 \
		--optype cipher-then-auth --ptest throughput --auth-key-sz 64 --cipher-key-sz 16 \
		--devtype crypto_qat --cipher-iv-sz 16 --auth-op generate --burst-sz 32 \
		--total-ops 30000000 --digest-sz 20 --auth-algo sha2-256-hmac --cipher-algo aes-cbc --cipher-op encrypt
		;;
	2)
		echo "(AES-GCM-128)"
		echo "sudo $DPDK_TEST_CRYPTO_PERF/dpdk-test-crypto-perf \
                --socket-mem 2048,0 --legacy-mem \
                -a ${QAT_PF0}.0  -a ${QAT_PF0}.1 -a ${QAT_PF0}.2 -a ${QAT_PF0}.3 \
                -l 4,5,13,6,14 -n 4 \
                -- --buffer-sz 64,128,256,512,1024,2048 \
                --aead-key-sz 16 --optype aead --ptest throughput --aead-aad-sz 16 --devtype crypto_qat --aead-op encrypt \
                --burst-sz 32 --total-ops 30000000 --digest-sz 16 --aead-algo aes-gcm --aead-iv-sz 12"

		sudo $DPDK_TEST_CRYPTO_PERF/dpdk-test-crypto-perf \
		--socket-mem 2048,0 --legacy-mem \
		-a ${QAT_PF0}.0  -a ${QAT_PF0}.1 -a ${QAT_PF0}.2 -a ${QAT_PF0}.3 \
		-l 4,5,13,6,14 -n 4 \
		-- --buffer-sz 64,128,256,512,1024,2048 \
		--aead-key-sz 16 --optype aead --ptest throughput --aead-aad-sz 16 --devtype crypto_qat --aead-op encrypt \
		--burst-sz 32 --total-ops 30000000 --digest-sz 16 --aead-algo aes-gcm --aead-iv-sz 12
		;;
esac
