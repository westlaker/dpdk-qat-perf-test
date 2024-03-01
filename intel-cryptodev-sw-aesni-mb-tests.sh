# from https://fast.dpdk.org/doc/perf/DPDK_23_03_Intel_crypto_performance_report.pdf
# TEST CASE : cryptodev-sw-aesni-mb-aes-cbc128-sha1-hmac
DPDK_TEST_CRYPTO_PERF=/home/ubuntu/dpdk-stable-21.11.4/build/app/
#DPDK_TEST_CRYPTO_PERF=/home/ubuntu/dpdk-stable-21.11.4/build/x86_64-native-linuxapp-gcc/app/
QAT_PF0=000c:03:01
QAT_PF1=000c:04:01
QAT_PF2=000c:05:01
#QAT_PF0=0000:c5:01
#QAT_PF1=0000:c6:01
#QAT_PF2=0000:c7:01

# results published by Intel
#Buffer Size (Bytes) AES-CBC-128/SHA1-HMAC (Gbps) AES-CBC-128/SHA2-256-HMAC (Gbps) AES-GCM-128 (Gbps)
#64 		     4.37 			  3.55 				   10.22
#128 		     7.44 			  5.95 				   14.77
#256 		     11.61 			  9.05 				   21.94
#512 		     16.14 			  12.26 			   28.85
#1024 		     19.99 			  14.89 			   34.24
#2048 		     22.79 			  16.68 			   37.85

case $1 in
	0)
		echo "sudo ${DPDK_TEST_CRYPTO_PERF}/dpdk-test-crypto-perf \
                --socket-mem 2048,0 --legacy-mem \
                -a ${QAT_PF0}.0 \
                --vdev crypto_aesni_mb_pmd_1 -l 9,10 -n 6 \
                -- --buffer-sz 64,128,256,512,1024,2048 \
                --optype cipher-then-auth --ptest throughput \
                --auth-key-sz 64 --cipher-key-sz 16 \
                --devtype crypto_aesni_mb \
                --cipher-iv-sz 16 --auth-op generate --burst-sz 32 \
                --total-ops 10000000 \
                --digest-sz 12 --auth-algo sha1-hmac --cipher-algo aes-cbc --cipher-op encrypt"
	
		sudo ${DPDK_TEST_CRYPTO_PERF}/dpdk-test-crypto-perf \
		--socket-mem 2048,0 --legacy-mem \
		-a ${QAT_PF0}.0 \
		--vdev crypto_aesni_mb_pmd_1 -l 9,10 -n 6 \
		-- --buffer-sz 64,128,256,512,1024,2048 \
		--optype cipher-then-auth --ptest throughput \
		--auth-key-sz 64 --cipher-key-sz 16 \
		--devtype crypto_aesni_mb \
		--cipher-iv-sz 16 --auth-op generate --burst-sz 32 \
		--total-ops 10000000 \
		--digest-sz 12 --auth-algo sha1-hmac --cipher-algo aes-cbc --cipher-op encrypt
		;;
	1)
		echo"sudo ${DPDK_TEST_CRYPTO_PERF}/dpdk-test-crypto-perf \
                --socket-mem 2048,0 --legacy-mem \
                 -a ${QAT_PF0}.0 \
                --vdev crypto_aesni_mb_pmd_1 -l 9,10 -n 6 \
                -- --buffer-sz 64,128,256,512,1024,2048 \
                --optype cipher-then-auth --ptest throughput \
                --auth-key-sz 64 --cipher-key-sz 16 \
                --devtype crypto_aesni_mb --cipher-iv-sz 16 --auth-op generate \
                --burst-sz 32 --total-ops 10000000 \
                --digest-sz 16 --auth-algo sha2-256-hmac --cipher-algo aes-cbc --cipher-op encrypt"

		sudo ${DPDK_TEST_CRYPTO_PERF}/dpdk-test-crypto-perf \
       		--socket-mem 2048,0 --legacy-mem \
	       	 -a ${QAT_PF0}.0 \
       	 	--vdev crypto_aesni_mb_pmd_1 -l 9,10 -n 6 \
        	-- --buffer-sz 64,128,256,512,1024,2048 \
        	--optype cipher-then-auth --ptest throughput \
        	--auth-key-sz 64 --cipher-key-sz 16 \
        	--devtype crypto_aesni_mb --cipher-iv-sz 16 --auth-op generate \
        	--burst-sz 32 --total-ops 10000000 \
        	--digest-sz 16 --auth-algo sha2-256-hmac --cipher-algo aes-cbc --cipher-op encrypt
		;;
	2)
		echo "sudo ${DPDK_TEST_CRYPTO_PERF}/dpdk-test-crypto-perf \
                --socket-mem 2048,0 --legacy-mem \
                -a ${QAT_PF0}.0 \
                --vdev crypto_aesni_gcm_pmd_1 -l 9,10 -n 6 \
                -- --aead-key-sz 16 --buffer-sz 64,128,256,512,1024,2048 \
                --optype aead --ptest throughput --aead-aad-sz 16 \
                --devtype crypto_aesni_gcm --aead-op encrypt --burst-sz 32 \
                --total-ops 10000000 --digest-sz 16 --aead-algo aes-gcm --aead-iv-sz 12"

		sudo ${DPDK_TEST_CRYPTO_PERF}/dpdk-test-crypto-perf \
        	--socket-mem 2048,0 --legacy-mem \
        	-a ${QAT_PF0}.0 \
        	--vdev crypto_aesni_gcm_pmd_1 -l 9,10 -n 6 \
        	-- --aead-key-sz 16 --buffer-sz 64,128,256,512,1024,2048 \
        	--optype aead --ptest throughput --aead-aad-sz 16 \
        	--devtype crypto_aesni_gcm --aead-op encrypt --burst-sz 32 \
        	--total-ops 10000000 --digest-sz 16 --aead-algo aes-gcm --aead-iv-sz 12
		;;
esac
