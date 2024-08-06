#!/usr/bin/bash
DPDK_TEST_CRYPTO_PERF=/opt/kalray/accesscore/share/dpdk/bin

# run DPDK crypto test
source /opt/kalray/accesscore/kalray.sh
export MPPA3_EP_PCIE_DRIVER_MODE=0
# run DPDK crypto test
cd $DPDK_TEST_CRYPTO_PERF

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

		./dpdk-test-crypto-perf \
		--iova-mode=pa -c 0x7ff \
		--vdev=crypto_mppa3_ep0 \ 
		-- --pool-sz 4096 --buffer-sz 64,128,256,512,1024,2048 \
		--optype cipher-only --ptest throughput \
		--devtype crypto_mppa3_ep --cipher-key-sz 16 --cipher-iv-sz 16 --burst-sz 32 \
		--total-ops 3000000 --cipher-algo aes-cbc --cipher-op encrypt
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
		  -l 4-7 -a ${QAT_PF0}.0 \
		  --vdev crypto_aesni_mb \
		  -- --devtype crypto_aesni_mb \
		  --buffer-sz 64,128,256,512,1024,2048 --cipher-algo aes-cbc \
		  --cipher-key-sz 16 --cipher-iv-sz 16 --cipher-op encrypt --optype cipher-only \
		  --burst-sz 32 --ptest throughput --total-ops 30000000 "

		sudo ${DPDK_TEST_CRYPTO_PERF}/dpdk-test-crypto-perf \
		  -l 2-3 -a ${QAT_PF0}.0 \
		  --vdev crypto_aesni_mb \
		  -- --devtype crypto_aesni_mb \
		  --buffer-sz 64,128,256,512,1024,2048 --cipher-algo aes-cbc \
		  --cipher-key-sz 16 --cipher-iv-sz 16 --cipher-op encrypt --optype cipher-only \
		  --burst-sz 32 --ptest throughput --total-ops 30000000
		;;

	3)
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

	5)

		echo "sudo ${DPDK_TEST_CRYPTO_PERF}/dpdk-test-crypto-perf \
		-l 1-2 -a ${QAT_PF0}.0 \
		-- --devtype crypto_qat --buffer-sz 64,128,256,512,1024,2048 \
		--cipher-algo aes-cbc --cipher-key-sz 16 --cipher-iv-sz 16 --cipher-op encrypt --optype cipher-only \
		--ptest throughput --total-ops 30000000"

		sudo ${DPDK_TEST_CRYPTO_PERF}/dpdk-test-crypto-perf \
		-l 1-2 -a ${QAT_PF0}.0 \
		-- --devtype crypto_qat --buffer-sz 64,128,256,512,1024,2048 \
		--cipher-algo aes-cbc --cipher-key-sz 16 --cipher-iv-sz 16 --cipher-op encrypt --optype cipher-only \
		--ptest throughput --total-ops 30000000
		;;
esac
