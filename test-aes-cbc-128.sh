DPDK_TEST_CRYPTO_PERF=home/ubuntu/dpdk-stable-21.11.1/build/app/
QAT_PF0=000c:03:01
QAT_PF1=000c:04:01
QAT_PF2=000c:05:01
#QAT_PF0=0000:c5:01
#QAT_PF1=0000:c6:01
#QAT_PF2=0000:c7:01

echo "QAT perf for AES-CBC-128/SHA1-HMAC"
sudo ${DPDK_TEST_CRYPTO_PERF}/dpdk-test-crypto-perf --socket-mem 2048,0 \
--legacy-mem -a 0000:1a:01.0 -a 0000:1c:01.0 -a 0000:1e:01.0 -a
0000:1a:01.1 -a 0000:1c:01.1 -a 0000:1e:01.1 -a 0000:1a:01.2 -a
0000:1c:01.2 -a 0000:1e:01.2 -a 0000:1a:01.3 -a 0000:1c:01.3 -a
0000:1e:01.3 -a 0000:1a:01.4 -a 0000:1c:01.4 -a 0000:1e:01.4 -a
0000:1a:01.5 -a 0000:1c:01.5 -a 0000:1e:01.5 --vdev
crypto_scheduler_pmd_1,worker=0000:1a:01.0_qat_sym,worker=0000:1c:01.0_qat
_sym,worker=0000:1e:01.0_qat_sym,mode=round-robin --vdev
crypto_scheduler_pmd_2,worker=0000:1a:01.1_qat_sym,worker=0000:1c:01.1_qat
_sym,worker=0000:1e:01.1_qat_sym,mode=round-robin --vdev
crypto_scheduler_pmd_3,worker=0000:1a:01.2_qat_sym,worker=0000:1c:01.2_qat
_sym,worker=0000:1e:01.2_qat_sym,mode=round-robin --vdev
crypto_scheduler_pmd_4,worker=0000:1a:01.3_qat_sym,worker=0000:1c:01.3_qat
_sym,worker=0000:1e:01.3_qat_sym,mode=round-robin --vdev
crypto_scheduler_pmd_5,worker=0000:1a:01.4_qat_sym,worker=0000:1c:01.4_qat
_sym,worker=0000:1e:01.4_qat_sym,mode=round-robin --vdev
crypto_scheduler_pmd_6,worker=0000:1a:01.5_qat_sym,worker=0000:1c:01.5_qat
_sym,worker=0000:1e:01.5_qat_sym,mode=round-robin -l 9,10,66,11,67,12,68 -
n 6 -- --buffer-sz 64,128,256,512,1024,2048 --optype cipher-then-auth --
ptest throughput --auth-key-sz 64 --cipher-key-sz 16 --devtype
crypto_scheduler --cipher-iv-sz 16 --auth-op generate --burst-sz 32 --
total-ops 30000000 --silent --digest-sz 20 --auth-algo sha1-hmac --
cipher-algo aes-cbc --cipher-op encrypt

./x86_64-native-linuxapp-gcc/app/dpdk-test-crypto-perf --socket-mem 2048,0
--legacy-mem -a 0000:1a:01.0 -a 0000:1c:01.0 -a 0000:1e:01.0 -a
0000:1a:01.1 -a 0000:1c:01.1 -a 0000:1e:01.1 -a 0000:1a:01.2 -a
0000:1c:01.2 -a 0000:1e:01.2 -a 0000:1a:01.3 -a 0000:1c:01.3 -a
0000:1e:01.3 -a 0000:1a:01.4 -a 0000:1c:01.4 -a 0000:1e:01.4 -a
0000:1a:01.5 -a 0000:1c:01.5 -a 0000:1e:01.5 --vdev
crypto_scheduler_pmd_1,worker=0000:1a:01.0_qat_sym,worker=0000:1c:01.0_qat
_sym,worker=0000:1e:01.0_qat_sym,mode=round-robin --
vdev=crypto_scheduler_pmd_2,worker=0000:1a:01.1_qat_sym,worker=0000:1c:01.
1_qat_sym,worker=0000:1e:01.1_qat_sym,mode=round-robin --
vdev=crypto_scheduler_pmd_3,worker=0000:1a:01.2_qat_sym,worker=0000:1c:01.
2_qat_sym,worker=0000:1e:01.2_qat_sym,mode=round-robin --
vdev=crypto_scheduler_pmd_4,worker=0000:1a:01.3_qat_sym,worker=0000:1c:01.
3_qat_sym,worker=0000:1e:01.3_qat_sym,mode=round-robin --
vdev=crypto_scheduler_pmd_5,worker=0000:1a:01.4_qat_sym,worker=0000:1c:01.
4_qat_sym,worker=0000:1e:01.4_qat_sym,mode=round-robin --
vdev=crypto_scheduler_pmd_6,worker=0000:1a:01.5_qat_sym,worker=0000:1c:01.
5_qat_sym,worker=0000:1e:01.5_qat_sym,mode=round-robin -l
9,10,66,11,67,12,68 -n 6 -- --buffer-sz 64,128,256,512,1024,2048 --optype
cipher-then-auth --ptest throughput --auth-key-sz 64 --cipher-key-sz 16 --
devtype crypto_scheduler --cipher-iv-sz 16 --auth-op generate --burst-sz
32 --total-ops 30000000 --silent --digest-sz 32 --auth-algo sha2-256-hmac
--cipher-algo aes-cbc --cipher-op encrypt

./x86_64-native-linuxapp-gcc/app/dpdk-test-crypto-perf --socket-mem 2048,0
--legacy-mem -a 0000:1a:01.0 -a 0000:1c:01.0 -a 0000:1e:01.0 -a
0000:1a:01.1 -a 0000:1c:01.1 -a 0000:1e:01.1 -a 0000:1a:01.2 -a
0000:1c:01.2 -a 0000:1e:01.2 -a 0000:1a:01.3 -a 0000:1c:01.3 -a
0000:1e:01.3 -a 0000:1a:01.4 -a 0000:1c:01.4 -a 0000:1e:01.4 -a
0000:1a:01.5 -a 0000:1c:01.5 -a 0000:1e:01.5 --vdev
crypto_scheduler_pmd_1,worker=0000:1a:01.0_qat_sym,worker=0000:1c:01.0_qat
_sym,worker=0000:1e:01.0_qat_sym,mode=round-robin --
vdev=crypto_scheduler_pmd_2,worker=0000:1a:01.1_qat_sym,worker=0000:1c:01.
1_qat_sym,worker=0000:1e:01.1_qat_sym,mode=round-robin --
vdev=crypto_scheduler_pmd_3,worker=0000:1a:01.2_qat_sym,worker=0000:1c:01.
2_qat_sym,worker=0000:1e:01.2_qat_sym,mode=round-robin --
vdev=crypto_scheduler_pmd_4,worker=0000:1a:01.3_qat_sym,worker=0000:1c:01.
3_qat_sym,worker=0000:1e:01.3_qat_sym,mode=round-robin --
vdev=crypto_scheduler_pmd_5,worker=0000:1a:01.4_qat_sym,worker=0000:1c:01.
4_qat_sym,worker=0000:1e:01.4_qat_sym,mode=round-robin --
vdev=crypto_scheduler_pmd_6,worker=0000:1a:01.5_qat_sym,worker=0000:1c:01.
5_qat_sym,worker=0000:1e:01.5_qat_sym,mode=round-robin -l
9,10,66,11,67,12,68 -n 6 -- --aead-key-sz 16 --buffer-sz
64,128,256,512,1024,2048 --optype aead --ptest throughput --aead-aad-sz 16
--devtype crypto_scheduler --aead-op encrypt --burst-sz 32 --total-ops
30000000 --silent --digest-sz 16 --aead-algo aes-gcm --aead-iv-sz 12

#sudo ${DPDK_TEST_CRYPTO_PERF}/dpdk-test-crypto-perf --socket-mem 2048,0 \
#--legacy-mem -a ${QAT_VF0} -a ${QAT_VF1} -a ${QAT_VF2} -a ${QAT_VF3} \
#-l 4,5,13,6,14 -n 4 -- --buffer-sz 64,128,256,512,1024,2048 \
#--optype cipher-then-auth --ptest throughput --auth-key-sz 64 \
#--cipher-key-sz 16 --devtype crypto_qat --cipher-iv-sz 16 --auth-op generate \
#--burst-sz 32 --total-ops 30000000 --silent --digest-sz 20 --auth-algo sha1-hmac \
#--cipher-algo aes-cbc --cipher-op encrypt

./x86_64-native-linuxapp-gcc/app/dpdk-test-crypto-perf --socket-mem 2048,0
--legacy-mem --vdev crypto_aesni_mb_pmd_1 -l 9,10 -n 6 -- --buffer-sz
64,128,256,512,1024,2048 --optype cipher-then-auth --ptest throughput --
auth-key-sz 64 --cipher-key-sz 16 --devtype crypto_aesni_mb --cipher-iv-sz
16 --auth-op generate --burst-sz 32 --total-ops 10000000 --silent --
digest-sz 12 --auth-algo sha1-hmac --cipher-algo aes-cbc --cipher-op
encrypt


./x86_64-native-linuxapp-gcc/app/dpdk-test-crypto-perf --socket-mem 2048,0
--legacy-mem --vdev crypto_aesni_mb_pmd_1 -l 9,10 -n 6 -- --buffer-sz
64,128,256,512,1024,2048 --optype cipher-then-auth --ptest throughput --
auth-key-sz 64 --cipher-key-sz 16 --devtype crypto_aesni_mb --cipher-iv-sz
16 --auth-op generate --burst-sz 32 --total-ops 10000000 --silent --
digest-sz 16 --auth-algo sha2-256-hmac --cipher-algo aes-cbc --cipher-op
encrypt

./x86_64-native-linuxapp-gcc/app/dpdk-test-crypto-perf --socket-mem 2048,0
--legacy-mem --vdev crypto_aesni_gcm_pmd_1 -l 9,10 -n 6 -- --aead-key-sz
16 --buffer-sz 64,128,256,512,1024,2048 --optype aead --ptest throughput -
-aead-aad-sz 16 --devtype crypto_aesni_gcm --aead-op encrypt --burst-sz 32
--total-ops 10000000 --silent --digest-sz 16 --aead-algo aes-gcm --aead-
iv-sz 12

