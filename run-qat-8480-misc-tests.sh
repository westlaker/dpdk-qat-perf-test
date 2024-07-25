#!/usr/bin/bash
DPDK_TEST_CRYPTO_PERF=/home/ubuntu/dpdk-stable-21.11.4/build/app/
DPDK_TEST_CRYPTO_PERF=/home/ubuntu/dpdk-stable-21.11.4/build/x86_64-native-linuxapp-gcc/app/
DPDK_TEST_CRYPTO_PERF=/home/ubuntu/dpdk/build/app
QAT_PF0=0000:c5:01
QAT_PF1=0000:c6:01
QAT_PF2=0000:c7:01
#QAT_PF0=000c:03:01
#QAT_PF1=000c:04:01
#QAT_PF2=000c:05:01
QAT_PF0=6b:00
QAT_PF1=6b:01

case $1 in
	0)
		echo "single VF AES-CBC Cipher Only"
		TEST="sudo $DPDK_TEST_CRYPTO_PERF/dpdk-test-crypto-perf \
		  -l 1-2 -a ${QAT_PF0}.1 \
		  -- --devtype crypto_qat \
		  --buffer-sz 64,128,256,512,1024,2048 --cipher-algo aes-cbc \
		  --cipher-key-sz 16 --cipher-iv-sz 16 --cipher-op encrypt --optype cipher-only \
		  --burst-sz 32 --ptest throughput --total-ops 3000000 "
		echo $TEST
		$TEST
		;;

	1)
		echo "single VF AES-CBC/SHA1-HMAC"
		TEST="sudo ${DPDK_TEST_CRYPTO_PERF}/dpdk-test-crypto-perf \
		  -l 2-3 -a ${QAT_PF0}.1 \
		  -- --devtype crypto_qat \
		  --buffer-sz 64,128,256,512,1024,2048 --cipher-algo aes-cbc \
		  --cipher-key-sz 16 --cipher-iv-sz 16 --cipher-op encrypt --optype cipher-then-auth \
		  --auth-op generate --digest-sz 20 --auth-algo sha1-hmac --auth-key-sz 64 \
		  --burst-sz 32 --ptest throughput --total-ops 30000000 "
		echo $TEST
		$TEST
		;;

	2)
		echo "single VF AES-CBC/SHA2-256-HMAC"
		TEST="sudo ${DPDK_TEST_CRYPTO_PERF}/dpdk-test-crypto-perf \
		  -l 2-3 -a ${QAT_PF0}.1 \
		  -- --devtype crypto_qat \
		  --buffer-sz 64,128,256,512,1024,2048 --cipher-algo aes-cbc \
		  --cipher-key-sz 16 --cipher-iv-sz 16 --cipher-op encrypt --optype cipher-then-auth \
		  --auth-op generate --digest-sz 20 --auth-algo sha2-256-hmac --auth-key-sz 64 \
		  --burst-sz 32 --ptest throughput --total-ops 30000000 "
		echo $TEST
		$TEST
		;;

	3)
		echo "single VF AES-GCM"
		TEST="sudo ${DPDK_TEST_CRYPTO_PERF}/dpdk-test-crypto-perf \
		-l 1-2 -a ${QAT_PF0}.1 \
		-- --devtype crypto_qat --buffer-sz 64,128,256,512,1024,2048 \
		--aead-key-sz 16 --optype aead --ptest throughput --aead-aad-sz 16 --aead-op encrypt \
		--burst-sz 32 --total-ops 30000000 --digest-sz 16 --aead-algo aes-gcm --aead-iv-sz 12"
		echo $TEST
		$TEST
		;;
esac
