# from https://fast.dpdk.org/doc/perf/DPDK_23_03_Intel_crypto_performance_report.pdf
# TEST CASE : cryptodev-qat-pmd-aes-cbc128-sha2-256-hmac
DPDK_TEST_CRYPTO_PERF=/home/ubuntu/dpdk-stable-21.11.4/build/app/
DPDK_TEST_CRYPTO_PERF=/home/ubuntu/dpdk-stable-21.11.4/build/x86_64-native-linuxapp-gcc/app/
QAT_PF0=0000:c5:01
QAT_PF1=0000:c6:01
QAT_PF2=0000:c7:01

# results published by Intel
#Buffer Size (Bytes) AES-CBC-128/SHA1-HMAC (Gbps) AES-CBC-128/SHA2-256-HMAC (Gbps) AES-GCM-128 (Gbps)
#64 		     9.50 			  9.39 				   8.27
#128 		     18.70 			  18.54 			   16.40
#256 		     35.89 			  35.58 			   31.73
#512 		     63.24 			  62.71 			   57.50
#1024 		     85.45 			  83.37 			   79.97
#2048 		     91.70 			  92.47 			   91.85

sudo ${DPDK_TEST_CRYPTO_PERF}/dpdk-test-crypto-perf \
	--socket-mem 2048,0 --legacy-mem \
	-a 0000:c5:01.0 -a 0000:c6:01.0 -a 0000:c7:01.0 \
	-a 0000:c5:01.1 -a 0000:c6:01.1 -a 0000:c7:01.1 \
	-a 0000:c5:01.2 -a 0000:c6:01.2 -a 0000:c7:01.2 \
	-a 0000:c5:01.3 -a 0000:c6:01.3 -a 0000:c7:01.3 \
	-a 0000:c5:01.4 -a 0000:c6:01.4 -a 0000:c7:01.4 \
	-a 0000:c5:01.5 -a 0000:c6:01.5 -a 0000:c7:01.5 \
	--vdev crypto_scheduler_pmd_1,worker=0000:c5:01.0_qat_sym,worker=0000:c6:01.0_qat_sym,worker=0000:c7:01.0_qat_sym,mode=round-robin \
	--vdev crypto_scheduler_pmd_2,worker=0000:c5:01.1_qat_sym,worker=0000:c6:01.1_qat_sym,worker=0000:c7:01.1_qat_sym,mode=round-robin \
	--vdev crypto_scheduler_pmd_3,worker=0000:c5:01.2_qat_sym,worker=0000:c6:01.2_qat_sym,worker=0000:c7:01.2_qat_sym,mode=round-robin \
	--vdev crypto_scheduler_pmd_4,worker=0000:c5:01.3_qat_sym,worker=0000:c6:01.3_qat_sym,worker=0000:c7:01.3_qat_sym,mode=round-robin \
	--vdev crypto_scheduler_pmd_5,worker=0000:c5:01.4_qat_sym,worker=0000:c6:01.4_qat_sym,worker=0000:c7:01.4_qat_sym,mode=round-robin \
	--vdev crypto_scheduler_pmd_6,worker=0000:c5:01.5_qat_sym,worker=0000:c6:01.5_qat_sym,worker=0000:c7:01.5_qat_sym,mode=round-robin \
	-l 9,10,66,11,67,12,68 -n 6 \
	-- --buffer-sz 64,128,256,512,1024,2048 --optype cipher-then-auth --ptest throughput \
	--auth-key-sz 64 --cipher-key-sz 16 --devtype crypto_scheduler \
	--cipher-iv-sz 16 --auth-op generate --burst-sz 32 \
	--total-ops 30000000 --silent --digest-sz 32 --auth-algo sha2-256-hmac --cipher-algo aes-cbc --cipher-op encrypt
