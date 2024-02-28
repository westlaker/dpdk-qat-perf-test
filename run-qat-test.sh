#!/usr/bin/bash
DPDK_TEST_CRYPTO_PERF=/home/ubuntu/dpdk-stable-21.11.4/build/app/
DPDK_TEST_CRYPTO_PERF=/home/ubuntu/dpdk-stable-21.11.4/build/x86_64-native-linuxapp-gcc/app/
QAT_PF0=0000:c5:01
QAT_PF1=0000:c6:01
QAT_PF2=0000:c7:01

timestamp() {
    date +"%Y-%m-%d-%H-%M-%S"
}

LOG_FILE=test-crypto-qat-$(timestamp).txt

#-l 9,10,66,11,67,12,68 -n 6 \
CORE_OPTION="-l 9,10,60,11,61,12,62 -n 6"
CORE_OPTION="-l 4,5,13,6,14,7,15 -n 6"


case $1 in
	0)
		echo "sudo $DPDK_TEST_CRYPTO_PERF/dpdk-test-crypto-perf \
		  -l 1-2 -a ${QAT_PF0}.0 \
		  -- --devtype crypto_qat \
		  --buffer-sz 64,128,256,512,1024,2048 --cipher-algo aes-cbc \
		  --cipher-key-sz 16 --cipher-iv-sz 16 --cipher-op encrypt --optype cipher-only \
		  --burst-sz 32 --ptest throughput --total-ops 3000000 "

		sudo $DPDK_TEST_CRYPTO_PERF/dpdk-test-crypto-perf \
		  -l 1-2 -a ${QAT_PF0}.0 \
		  -- --devtype crypto_qat \
		  --buffer-sz 64,128,256,512,1024,2048 --cipher-algo aes-cbc \
		  --cipher-key-sz 16 --cipher-iv-sz 16 --cipher-op encrypt --optype cipher-only \
		  --burst-sz 32 --ptest throughput --total-ops 30000000 
		;;

	1)

		echo "sudo ${DPDK_TEST_CRYPTO_PERF}/dpdk-test-crypto-perf \
		  -l 2-3 -a ${QAT_PF0}.0 \
		  -- --devtype crypto_qat \
		  --buffer-sz 64,128,256,512,1024,2048 --cipher-algo aes-cbc \
		  --cipher-key-sz 16 --cipher-iv-sz 16 --cipher-op encrypt --optype cipher-then-auth \
		  --auth-op generate --digest-sz 20 --auth-algo sha1-hmac --auth-key-sz 64 \
		  --burst-sz 32 --ptest throughput --total-ops 30000000 "

		sudo ${DPDK_TEST_CRYPTO_PERF}/dpdk-test-crypto-perf \
		  -l 2-3 -a ${QAT_PF0}.0 \
		  -- --devtype crypto_qat \
		  --buffer-sz 64,128,256,512,1024,2048 --cipher-algo aes-cbc \
		  --cipher-key-sz 16 --cipher-iv-sz 16 --cipher-op encrypt --optype cipher-then-auth \
		  --auth-op generate --digest-sz 20 --auth-algo sha1-hmac --auth-key-sz 64 \
		  --burst-sz 32 --ptest throughput --total-ops 30000000 
		;;

	2)

		echo "sudo ${DPDK_TEST_CRYPTO_PERF}/dpdk-test-crypto-perf \
		  -l 2-3 -a ${QAT_PF0}.0 \
		  --vdev crypto_aesni_mb \
		  -- --devtype crypto_aesni_mb \
		  --buffer-sz 64,128,256,512,1024,2048 --cipher-algo aes-cbc \
		  --cipher-key-sz 16 --cipher-iv-sz 16 --cipher-op encrypt --optype cipher-then-auth \
		  --auth-op generate --digest-sz 12 --auth-algo sha1-hmac --auth-key-sz 64 \
		  --burst-sz 32 --ptest throughput --total-ops 30000000 "


		sudo ${DPDK_TEST_CRYPTO_PERF}/dpdk-test-crypto-perf \
		  -l 2-3 -a ${QAT_PF0}.0 \
		  --vdev crypto_aesni_mb \
		  -- --devtype crypto_aesni_mb \
		  --buffer-sz 64,128,256,512,1024,2048 --cipher-algo aes-cbc \
		  --cipher-key-sz 16 --cipher-iv-sz 16 --cipher-op encrypt --optype cipher-then-auth \
		  --auth-op generate --digest-sz 12 --auth-algo sha1-hmac --auth-key-sz 64 \
		  --burst-sz 32 --ptest throughput --total-ops 30000000 
		;;
	3)

		echo "sudo ${DPDK_TEST_CRYPTO_PERF}/dpdk-test-crypto-perf \
		  -l 4-7 -a ${QAT_PF0}.0 \
		  --vdev crypto_aesni_mb1 \
		  --vdev crypto_aesni_mb2 \
		  -- --devtype crypto_aesni_mb \
		  --buffer-sz 64,128,256,512,1024,2048 --cipher-algo aes-cbc \
		  --cipher-key-sz 16 --cipher-iv-sz 16 --cipher-op encrypt --optype cipher-only \
		  --burst-sz 32 --ptest latency --total-ops 30 "

		sudo ${DPDK_TEST_CRYPTO_PERF}/dpdk-test-crypto-perf \
		  -l 4-7 -a ${QAT_PF0}.0 \
		  --vdev crypto_aesni_mb1 \
		  --vdev crypto_aesni_mb2 \
		  -- --devtype crypto_aesni_mb \
		  --buffer-sz 64,128,256,512,1024,2048 --cipher-algo aes-cbc \
		  --cipher-key-sz 16 --cipher-iv-sz 16 --cipher-op encrypt --optype cipher-only \
		  --burst-sz 32 --ptest latency --total-ops 30
		;;
	4)

		echo "sudo ${DPDK_TEST_CRYPTO_PERF}/dpdk-test-crypto-perf \
		  -l 4-7 -a ${QAT_PF0}.0 \
		  --vdev crypto_openssl \
		  -- --devtype crypto_openssl \
		  --buffer-sz 64,128,256,512,1024,2048 --aead-algo aes-gcm \
		  --aead-key-sz 16 --aead-iv-sz 16 --aead-op encrypt --aead-aad-sz 16 --digest-sz 16 --optype aead \
		  --burst-sz 32 --ptest verify --total-ops 30 --test-file test_aes_gcm.data"

		sudo ${DPDK_TEST_CRYPTO_PERF}/dpdk-test-crypto-perf \
		  -l 4-7 -a ${QAT_PF0}.0 \
		  --vdev crypto_openssl \
		  -- --devtype crypto_openssl \
		  --buffer-sz 64,128,256,512,1024,2048 --aead-algo aes-gcm \
		  --aead-key-sz 16 --aead-iv-sz 16 --aead-op encrypt --aead-aad-sz 16 --digest-sz 16 --optype aead \
		  --burst-sz 32 --ptest verify --total-ops 30 --test-file test_aes_gcm.data
		;;
esac
