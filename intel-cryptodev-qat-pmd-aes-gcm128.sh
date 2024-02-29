# from https://fast.dpdk.org/doc/perf/DPDK_23_03_Intel_crypto_performance_report.pdf
# TEST CASE : cryptodev-qat-pmd-aes-gcm128
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
#64 		     9.50 			  9.39 				   8.27
#128 		     18.70 			  18.54 			   16.40
#256 		     35.89 			  35.58 			   31.73
#512 		     63.24 			  62.71 			   57.50
#1024 		     85.45 			  83.37 			   79.97
#2048 		     91.70 			  92.47 			   91.85

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
	-l 9,10,60,11,61,12,62 -n 6 \
	-- --aead-key-sz 16 --buffer-sz 64,128,256,512,1024,2048 \
	--optype aead --ptest throughput --aead-aad-sz 16 \
	--devtype crypto_scheduler --aead-op encrypt --burst-sz 32 --total-ops 30000000 \
	--digest-sz 16 --aead-algo aes-gcm --aead-iv-sz 12

