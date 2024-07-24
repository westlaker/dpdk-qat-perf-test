#!/usr/bin/bash
DPDK_TEST_CRYPTO_PERF=/opt/kalray/accesscore/share/dpdk/bin

#./dpdk-test-crypto-perf --iova-mode=pa -c 0x7ff \
#	--vdev=crypto_mppa3_ep0 --vdev=crypto_mppa3_ep1 --vdev=crypto_mppa3_ep2 --vdev=crypto_mppa3_ep3 --vdev=crypto_mppa3_ep4 \
#	--vdev=crypto_mppa3_ep5  --vdev=crypto_mppa3_ep6  --vdev=crypto_mppa3_ep7  --vdev=crypto_mppa3_ep8  --vdev=crypto_mppa3_ep9 -- \
#	--pool-sz 4096 --buffer-sz 64,128,256,512,1024,2048 --optype cipher-then-auth --ptest throughput --auth-key-sz 64 --cipher-key-sz 16 \
#	--devtype crypto_mppa3_ep --cipher-iv-sz 16 --auth-op generate --burst-sz 32 --total-ops 1000000 --silent \
#	--digest-sz 12 --auth-algo sha1-hmac --cipher-algo aes-cbc --cipher-op encrypt

# run DPDK crypto test
source /opt/kalray/accesscore/kalray.sh
export MPPA3_EP_PCIE_DRIVER_MODE=0
# run DPDK crypto test
cd $DPDK_TEST_CRYPTO_PERF
case $1 in
	0)
		echo "Kalray (AES-CBC128/SHA1-HMAC)"
		echo "./dpdk-test-crypto-perf \
		--iova-mode=pa -c 0x7ff \
		--vdev=crypto_mppa3_ep0 --vdev=crypto_mppa3_ep1 --vdev=crypto_mppa3_ep2 --vdev=crypto_mppa3_ep3 --vdev=crypto_mppa3_ep4 \
		--vdev=crypto_mppa3_ep5  --vdev=crypto_mppa3_ep6  --vdev=crypto_mppa3_ep7  --vdev=crypto_mppa3_ep8  --vdev=crypto_mppa3_ep9 \
		-- --pool-sz 4096 --buffer-sz 64,128,256,512,1024,2048 \
		--optype cipher-then-auth --ptest throughput --auth-key-sz 64 --cipher-key-sz 16 \
		--devtype crypto_mppa3_ep --cipher-iv-sz 16 --auth-op generate --burst-sz 32 \
		--total-ops 30000000 --digest-sz 20 --auth-algo sha1-hmac --cipher-algo aes-cbc --cipher-op encrypt"

		./dpdk-test-crypto-perf \
		--iova-mode=pa -c 0x7ff \
		--vdev=crypto_mppa3_ep0 --vdev=crypto_mppa3_ep1 --vdev=crypto_mppa3_ep2 --vdev=crypto_mppa3_ep3 --vdev=crypto_mppa3_ep4 \
		--vdev=crypto_mppa3_ep5  --vdev=crypto_mppa3_ep6  --vdev=crypto_mppa3_ep7  --vdev=crypto_mppa3_ep8  --vdev=crypto_mppa3_ep9 \
		-- --pool-sz 4096 --buffer-sz 64,128,256,512,1024,2048 \
		--optype cipher-then-auth --ptest throughput --auth-key-sz 64 --cipher-key-sz 16 \
		--devtype crypto_mppa3_ep --cipher-iv-sz 16 --auth-op generate --burst-sz 32 \
		--total-ops 3000000 --digest-sz 12 --auth-algo sha1-hmac --cipher-algo aes-cbc --cipher-op encrypt
		;;
	1)
		echo "Kalray (AES-CBC128/SHA2-256-HMAC)"
		echo "./dpdk-test-crypto-perf \
		--iova-mode=pa -c 0x7ff \
		--vdev=crypto_mppa3_ep0 --vdev=crypto_mppa3_ep1 --vdev=crypto_mppa3_ep2 --vdev=crypto_mppa3_ep3 --vdev=crypto_mppa3_ep4 \
		--vdev=crypto_mppa3_ep5  --vdev=crypto_mppa3_ep6  --vdev=crypto_mppa3_ep7  --vdev=crypto_mppa3_ep8  --vdev=crypto_mppa3_ep9 \
		-- --pool-sz 4096 --buffer-sz 64,128,256,512,1024,2048 \
		--optype cipher-then-auth --ptest throughput --auth-key-sz 64 --cipher-key-sz 16 \
		--devtype crypto_mppa3_ep --cipher-iv-sz 16 --auth-op generate --burst-sz 32 \
		--total-ops 30000000 --digest-sz 20 --auth-algo sha2-256-hmac --cipher-algo aes-cbc --cipher-op encrypt"

		./dpdk-test-crypto-perf \
		--iova-mode=pa -c 0x7ff \
		--vdev=crypto_mppa3_ep0 --vdev=crypto_mppa3_ep1 --vdev=crypto_mppa3_ep2 --vdev=crypto_mppa3_ep3 --vdev=crypto_mppa3_ep4 \
		--vdev=crypto_mppa3_ep5  --vdev=crypto_mppa3_ep6  --vdev=crypto_mppa3_ep7  --vdev=crypto_mppa3_ep8  --vdev=crypto_mppa3_ep9 \
		-- --pool-sz 4096 --buffer-sz 64,128,256,512,1024,2048 \
		--optype cipher-then-auth --ptest throughput --auth-key-sz 64 --cipher-key-sz 16 \
		--devtype crypto_mppa3_ep --cipher-iv-sz 16 --auth-op generate --burst-sz 32 \
		--total-ops 30000000 --digest-sz 12 --auth-algo sha2-256-hmac --cipher-algo aes-cbc --cipher-op encrypt
		;;
	2)
		echo "Kalray (AES-GCM-128)"
		echo "./dpdk-test-crypto-perf \
		--iova-mode=pa -c 0x7ff \
		--vdev=crypto_mppa3_ep0 --vdev=crypto_mppa3_ep1 --vdev=crypto_mppa3_ep2 --vdev=crypto_mppa3_ep3 --vdev=crypto_mppa3_ep4 \
		--vdev=crypto_mppa3_ep5  --vdev=crypto_mppa3_ep6  --vdev=crypto_mppa3_ep7  --vdev=crypto_mppa3_ep8  --vdev=crypto_mppa3_ep9 \
		-- --pool-sz 4096 --buffer-sz 64,128,256,512,1024,2048 \
		--aead-key-sz 16 --optype aead --ptest throughput --aead-aad-sz 16 --devtype crypto_qat --aead-op encrypt \
		--burst-sz 32 --total-ops 30000000 --digest-sz 16 --aead-algo aes-gcm --aead-iv-sz 12"

		./dpdk-test-crypto-perf \
		--iova-mode=pa -c 0x7ff \
		--vdev=crypto_mppa3_ep0 --vdev=crypto_mppa3_ep1 --vdev=crypto_mppa3_ep2 --vdev=crypto_mppa3_ep3 --vdev=crypto_mppa3_ep4 \
		--vdev=crypto_mppa3_ep5  --vdev=crypto_mppa3_ep6  --vdev=crypto_mppa3_ep7  --vdev=crypto_mppa3_ep8  --vdev=crypto_mppa3_ep9 \
		-- --pool-sz 4096 --buffer-sz 64,128,256,512,1024,2048 \
		--aead-key-sz 16 --optype aead --ptest throughput --aead-aad-sz 16 --devtype crypto_mppa3_ep --aead-op encrypt \
		--burst-sz 32 --total-ops 30000000 --digest-sz 16 --aead-algo aes-gcm --aead-iv-sz 12
		;;
esac
