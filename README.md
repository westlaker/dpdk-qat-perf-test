# dpdk-qat-perf-test

dpdk-test-crypto-perf

Reference Links:

	https://fast.dpdk.org/doc/perf/DPDK_22_11_Intel_crypto_performance_report.pdf

	https://intel.github.io/quickassist/index.html

	https://doc.dpdk.org/guides/tools/cryptoperf.html

	https://doc.dpdk.org/guides/cryptodevs/qat.html

EAL options:
	-c <COREMASK> or -l <CORELIST>
		set hex bitmask of the cores to run OR the a list of cores to run
	-a <PCI>
		add a PCIe device
	--vdev <driver><id>
		add a virtual device

APP options:

--ptest type
	throughput
	latency
	verify
	pmd-cyclecount

--devtype <name>
	Set device type, where name is one of the following:

		crypto_aesni_gcm
		crypto_aesni_mb
		crypto_armv8
		crypto_cn9k
		crypto_cn10k
		crypto_dpaa_sec
		crypto_dpaa2_sec
		crypto_kasumi
		crypto_mvsam
		crypto_null
		crypto_octeontx
		crypto_openssl
		crypto_qat
		crypto_scheduler
		crypto_snow3g
		crypto_zuc

--optype <name>
	Set operation type, where name is one of the following:

		cipher-only
		auth-only
		cipher-then-auth
		auth-then-cipher
		aead
			For GCM/CCM algorithms you should use aead flag.
		pdcp
		docsis
		modex

--cipher-algo <name>
	Set cipher algorithm name, where name is one of the following:

		3des-cbc
		3des-ecb
		3des-ctr
		aes-cbc
		aes-ctr
		aes-ecb
		aes-f8
		aes-xts
		arc4
		null
		kasumi-f8
		snow3g-uea2
		zuc-eea3

--cipher-op <mode>
	Set cipher operation mode, where mode is one of the following:

		encrypt
		decrypt

--cipher-key-sz <n>
	Set the size of cipher key.

--cipher-iv-sz <n>
	Set the size of cipher iv.

--auth-algo <name>
	Set authentication algorithm name, where name is one of the following:

		aes-cbc-mac
		aes-cmac
		aes-gmac
		aes-xcbc-mac
		md5
		md5-hmac
		sha1
		sha1-hmac
		sha2-224
		sha2-224-hmac
		sha2-256
		sha2-256-hmac
		sha2-384
		sha2-384-hmac
		sha2-512
		sha2-512-hmac
		kasumi-f9
		snow3g-uia2
		zuc-eia3

--auth-op <mode>
	Set authentication operation mode, where mode is one of the following:

		verify
		generate

--auth-key-sz <n>
	Set the size of authentication key.

--auth-iv-sz <n>
	Set the size of auth iv.

--aead-algo <name>
	Set AEAD algorithm name, where name is one of the following:

		aes-ccm
		aes-gcm

--aead-op <mode>
	Set AEAD operation mode, where mode is one of the following:

		encrypt
		decrypt

--aead-key-sz <n>
	Set the size of AEAD key.

--aead-iv-sz <n>
	Set the size of AEAD iv.

--aead-aad-sz <n>
	Set the size of AEAD aad.

--digest-sz <n>
	Set the size of digest.

--desc-nb <n>
	Set number of descriptors for each crypto device.

--pmd-cyclecount-delay-ms <n>
	Add a delay (in milliseconds) between enqueue and dequeue in pmd-cyclecount benchmarking mode (useful when benchmarking hardware acceleration).

--csv-friendly
	Enable test result output CSV friendly rather than human friendly.

--pdcp-sn-sz <n>
	Set PDCP sequence number size(n) in bits. Valid values of n will be 5/7/12/15/18.

--pdcp-domain <control/user>
	Set PDCP domain to specify short_mac/control/user plane.

--docsis-hdr-sz <n>
	Set DOCSIS header size(n) in bytes.

--pdcp-ses-hfn-en
	Enable fixed session based HFN instead of per packet HFN.

--enable-sdap
	Enable Service Data Adaptation Protocol.

--modex-len <n>
	Set modex length for asymmetric crypto perf test. Supported lengths are 60, 128, 255, 448. Default length is 128.

--sessionless
	Enable session-less crypto operations mode.

--out-of-place
	Enable out-of-place crypto operations mode.

--test-file <name>
	Set test vector file path. See the Test Vector File chapter.

--test-name <name>
	Set specific test name section in the test vector file.

--silent
	Disable options dump.

--pool-sz <n>
	Set the number of mbufs to be allocated in the mbuf pool.

--total-ops <n>
	Set the number of total operations performed.

--burst-sz <n>
	Set the number of packets per burst.
	This can be set as:
		Single value (i.e. --burst-sz 16)
		Range of values, using the following structure min:inc:max, where min is minimum size, inc is the increment size and max is the maximum size (i.e. --burst-sz 16:2:32)
		List of values, up to 32 values, separated in commas (i.e. --burst-sz 16,24,32)

--buffer-sz <n>
	Set the size of single packet (plaintext or ciphertext in it).
	This can be set as:
		Single value (i.e. --buffer-sz 16)
		Range of values, using the following structure min:inc:max, where min is minimum size, inc is the increment size and max is the maximum size (i.e. --buffer-sz 16:2:32)
		List of values, up to 32 values, separated in commas (i.e. --buffer-sz 32,64,128)

--imix <n>
	Set the distribution of packet sizes.
	A list of weights must be passed, containing the same number of items than buffer-sz, so each item in this list will be the weight of the packet size on the same position in the buffer-sz parameter (a list have to be passed in that parameter).

Example:
	To test a distribution of 20% packets of 64 bytes, 40% packets of 100 bytes and 40% packets of 256 bytes, the command line would be: --buffer-sz 64,100,256 --imix 20,40,40. Note that the weights do not have to be percentages, so using --imix 1,2,2 would result in the same distribution

--segment-sz <n>
	Set the size of the segment to use, for Scatter Gather List testing. By default, it is set to the size of the maximum buffer size, including the digest size, so a single segment is created.

================================================

root@xeon-sm-01:/QAT# ./run-test.sh 
$DPDK_TEST_CRYPTO_PERF/dpdk-test-crypto-perf -l 1-2 -a 0000:c5:01.0 -- --devtype crypto_qat --buffer-sz 128 --cipher-algo aes-cbc --cipher-key-sz 16 --cipher-iv-sz 16 --cipher-op encrypt --optype cipher-only --silent --ptest throughput --total-ops 20000
EAL: Detected CPU lcores: 64
EAL: Detected NUMA nodes: 1
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
EAL: Selected IOVA mode 'PA'
EAL: No available 2048 kB hugepages reported
EAL: VFIO support initialized
EAL: Using IOMMU type 1 (Type 1)
EAL: Probe PCI driver: qat (8086:37c9) device: 0000:c5:01.0 (socket 0)
CRYPTODEV: Creating cryptodev 0000:c5:01.0_qat_sym
CRYPTODEV: Initialisation parameters - name: 0000:c5:01.0_qat_sym,socket id: 0, max queue pairs: 0
CRYPTODEV: Creating cryptodev 0000:c5:01.0_qat_asym
CRYPTODEV: Initialisation parameters - name: 0000:c5:01.0_qat_asym,socket id: 0, max queue pairs: 0
Allocated pool "priv_sess_mp_0" on socket 0
CRYPTODEV: elt_size 0 is expanded to 384
Allocated pool "sess_mp_0" on socket 0
    lcore id    Buf Size  Burst Size    Enqueued    Dequeued  Failed Enq  Failed Deq        MOps        Gbps  Cycles/Buf

           2         128          32       20000       20000       19197       20584      8.3078      8.5072      264.81


$DPDK_TEST_CRYPTO_PERF/dpdk-test-crypto-perf -l 1-2 -a 0000:c5:01.0 -- --devtype crypto_qat --buffer-sz 64,128,256,512,1024,2048 --cipher-algo aes-cbc --cipher-key-sz 16 --cipher-iv-sz 16 --cipher-op encrypt --optype cipher-only --silent --ptest throughput --total-ops 30000000
EAL: Detected CPU lcores: 64
EAL: Detected NUMA nodes: 1
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
EAL: Selected IOVA mode 'PA'
EAL: No available 2048 kB hugepages reported
EAL: VFIO support initialized
EAL: Using IOMMU type 1 (Type 1)
EAL: Probe PCI driver: qat (8086:37c9) device: 0000:c5:01.0 (socket 0)
CRYPTODEV: Creating cryptodev 0000:c5:01.0_qat_sym
CRYPTODEV: Initialisation parameters - name: 0000:c5:01.0_qat_sym,socket id: 0, max queue pairs: 0
CRYPTODEV: Creating cryptodev 0000:c5:01.0_qat_asym
CRYPTODEV: Initialisation parameters - name: 0000:c5:01.0_qat_asym,socket id: 0, max queue pairs: 0
Allocated pool "priv_sess_mp_0" on socket 0
CRYPTODEV: elt_size 0 is expanded to 384
Allocated pool "sess_mp_0" on socket 0
    lcore id    Buf Size  Burst Size    Enqueued    Dequeued  Failed Enq  Failed Deq        MOps        Gbps  Cycles/Buf

           2          64          32    30000000    30000000    46336996    41002399      6.5919      3.3750      333.74
           2         128          32    30000000    30000000    44924829    39301224      6.5739      6.7316      334.66
           2         256          32    30000000    30000000    39289695    32896332      6.5958     13.5081      333.55
           2         512          32    30000000    30000000    35686881    28074496      6.5686     26.9052      334.92
           2        1024          32    30000000    30000000    56776310    46850295      4.8532     39.7578      453.31
           2        2048          32    30000000    30000000   196942525   189059223      2.5404     41.6215      866.01

root@xeon-sm-01:/QAT# ./run-test.sh 
$DPDK_TEST_CRYPTO_PERF/dpdk-test-crypto-perf -l 1-3 -a 0000:c5:01.0 -- --devtype crypto_qat --buffer-sz 64,128,256,512,1024,2048 --cipher-algo aes-cbc --cipher-key-sz 16 --cipher-iv-sz 16 --cipher-op encrypt --optype cipher-only --silent --ptest throughput --total-ops 30000000 #20000

EAL: Detected CPU lcores: 64
EAL: Detected NUMA nodes: 1
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
EAL: Selected IOVA mode 'PA'
EAL: No available 2048 kB hugepages reported
EAL: VFIO support initialized
EAL: Using IOMMU type 1 (Type 1)
EAL: Probe PCI driver: qat (8086:37c9) device: 0000:c5:01.0 (socket 0)
CRYPTODEV: Creating cryptodev 0000:c5:01.0_qat_sym
CRYPTODEV: Initialisation parameters - name: 0000:c5:01.0_qat_sym,socket id: 0, max queue pairs: 0
CRYPTODEV: Creating cryptodev 0000:c5:01.0_qat_asym
CRYPTODEV: Initialisation parameters - name: 0000:c5:01.0_qat_asym,socket id: 0, max queue pairs: 0
Allocated pool "priv_sess_mp_0" on socket 0
CRYPTODEV: elt_size 0 is expanded to 384
Allocated pool "sess_mp_0" on socket 0

    lcore id    Buf Size  Burst Size    Enqueued    Dequeued  Failed Enq  Failed Deq        MOps        Gbps  Cycles/Buf

           2          64          32    30000000    30000000    92622314    83860534      4.1561      2.1279      529.34
           3          64          32    30000000    30000000    93437405    84661024      4.1555      2.1276      529.41
           3         128          32    30000000    30000000    93770960    84735866      4.1156      4.2144      534.55
           2         128          32    30000000    30000000    92926802    83894894      4.1155      4.2143      534.56
           2         256          32    30000000    30000000    90846997    80775843      4.0356      8.2648      545.15
           3         256          32    30000000    30000000    91722915    81641334      4.0352      8.2642      545.20
           2         512          32    30000000    30000000    85548943    72932139      3.8408     15.7319      572.80
           3         512          32    30000000    30000000    86590422    73945649      3.8405     15.7308      572.84
           3        1024          32    30000000    30000000   151942634   137085860      2.6670     21.8478      824.91
           2        1024          32    30000000    30000000   150188742   135348485      2.6669     21.8475      824.92
           2        2048          32    30000000    30000000   426769812   414111927      1.3118     21.4928     1677.06
           3        2048          32    30000000    30000000   429611159   416893155      1.3118     21.4921     1677.12


root@xeon-sm-01:/QAT# ./run-test.sh 
$DPDK_TEST_CRYPTO_PERF/dpdk-test-crypto-perf -l 1-2 -a 0000:c5:01.0 -a 0000:c5:01.1 -- --devtype crypto_qat --buffer-sz 64,128,256,512,1024,2048 --cipher-algo aes-cbc --cipher-key-sz 16 --cipher-iv-sz 16 --cipher-op encrypt --optype cipher-only --silent --ptest throughput --total-ops 30000000
EAL: Detected CPU lcores: 64
EAL: Detected NUMA nodes: 1
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
EAL: Selected IOVA mode 'PA'
EAL: No available 2048 kB hugepages reported
EAL: VFIO support initialized
EAL: Using IOMMU type 1 (Type 1)
EAL: Probe PCI driver: qat (8086:37c9) device: 0000:c5:01.0 (socket 0)
CRYPTODEV: Creating cryptodev 0000:c5:01.0_qat_sym
CRYPTODEV: Initialisation parameters - name: 0000:c5:01.0_qat_sym,socket id: 0, max queue pairs: 0
CRYPTODEV: Creating cryptodev 0000:c5:01.0_qat_asym
CRYPTODEV: Initialisation parameters - name: 0000:c5:01.0_qat_asym,socket id: 0, max queue pairs: 0
EAL: Probe PCI driver: qat (8086:37c9) device: 0000:c5:01.1 (socket 0)
CRYPTODEV: Creating cryptodev 0000:c5:01.1_qat_sym
CRYPTODEV: Initialisation parameters - name: 0000:c5:01.1_qat_sym,socket id: 0, max queue pairs: 0
CRYPTODEV: Creating cryptodev 0000:c5:01.1_qat_asym
CRYPTODEV: Initialisation parameters - name: 0000:c5:01.1_qat_asym,socket id: 0, max queue pairs: 0
Allocated pool "priv_sess_mp_0" on socket 0
CRYPTODEV: elt_size 0 is expanded to 384
Allocated pool "sess_mp_0" on socket 0
    lcore id    Buf Size  Burst Size    Enqueued    Dequeued  Failed Enq  Failed Deq        MOps        Gbps  Cycles/Buf

           2          64          32    30000000    30000000    57120310    52872213      6.4566      3.3058      340.74
           2         128          32    30000000    30000000    65893004    61429072      5.7708      5.9093      381.23
           2         256          32    30000000    30000000    61854036    56755943      5.6854     11.6436      386.96
           2         512          32    30000000    30000000    47159189    40288757      5.8677     24.0342      374.93
           2        1024          32    30000000    30000000    60307338    50383181      4.7103     38.5870      467.06
           2        2048          32    30000000    30000000   199126532   191335254      2.5092     41.1103      876.78


=======
these are from Intel DPDK QAT PERF test:
https://fast.dpdk.org/doc/perf/DPDK_22_11_Intel_crypto_performance_report.pdf

    lcore id    Buf Size  Burst Size    Enqueued    Dequeued  Failed Enq  Failed Deq        MOps        Gbps  Cycles/Buf

           6          64          32    30000000    30000000   207154813   190275557      1.4011      0.7174     1570.21
           6         128          32    30000000    30000000   245749010   229377254      1.1980      1.2268     1836.39
           6         256          32    30000000    30000000   232974557   216110094      1.1863      2.4295     1854.56
           6         512          32    30000000    30000000   267247190   245619289      1.0293      4.2159     2137.44
           6        1024          32    30000000    30000000   356333538   333632083      0.8837      7.2389     2489.66
           6        2048          32    30000000    30000000   756740714   735605286      0.4849      7.9446     4537.01

sudo ${DPDK_TEST_CRYPTO_PERF}/dpdk-test-crypto-perf --socket-mem 2048,0 --legacy-mem \
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
$CORE_OPTION \
-- --buffer-sz 64,128,256,512,1024,2048 --optype cipher-then-auth --ptest throughput --auth-key-sz 64 \
--cipher-key-sz 16 --devtype crypto_scheduler --cipher-iv-sz 16 --auth-op generate --burst-sz 32 --total-ops 30000000 --silent \
--digest-sz 20 --auth-algo sha1-hmac --cipher-algo aes-cbc --cipher-op encrypt

sudo ${DPDK_TEST_CRYPTO_PERF}/dpdk-test-crypto-perf --socket-mem 2048,0 --legacy-mem \
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
$CORE_OPTION \
-- --buffer-sz 64,128,256,512,1024,2048 --optype cipher-then-auth --ptest throughput --auth-key-sz 64 \
--cipher-key-sz 16 --devtype crypto_scheduler --cipher-iv-sz 16 --auth-op generate --burst-sz 32 --total-ops 30000000 --silent \
--digest-sz 32 --auth-algo sha2-256-hmac --cipher-algo aes-cbc --cipher-op encrypt

sudo ${DPDK_TEST_CRYPTO_PERF}/dpdk-test-crypto-perf --socket-mem 2048,0 --legacy-mem \
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
$CORE_OPTION \
-- --aead-key-sz 16 --buffer-sz 64,128,256,512,1024,2048 --optype aead --ptest throughput --aead-aad-sz 16 \
--devtype crypto_scheduler --aead-op encrypt --burst-sz 32 --total-ops 30000000 --silent \
--digest-sz 16 --aead-algo aes-gcm --aead-iv-sz 12 

ubuntu@xeon-sm-01:/QAT$ sudo ./run-test.sh 

$DPDK_TEST_CRYPTO_PERF/dpdk-test-crypto-perf -l 1-2 -a ${QAT_PF0}.0 --vdev crypto_scheduler_pmd_1,worker=${QAT_PF0}.0_qat_sym,worker=${QAT_PF1}.0_qat_sym,worker=${QAT_PF2}.0_qat_sym,mode=round-robin -- --devtype crypto_qat --buffer-sz 64,128,256,512,1024,2048 --cipher-algo aes-cbc --cipher-key-sz 16 --cipher-iv-sz 16 --cipher-op encrypt --optype cipher-only --silent --ptest throughput --total-ops 30000000

EAL: Detected CPU lcores: 64
EAL: Detected NUMA nodes: 1
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
EAL: Selected IOVA mode 'PA'
EAL: No available 2048 kB hugepages reported
EAL: VFIO support initialized
EAL: Using IOMMU type 1 (Type 1)
EAL: Probe PCI driver: qat (8086:37c9) device: 0000:c5:01.0 (socket 0)
CRYPTODEV: Creating cryptodev 0000:c5:01.0_qat_sym
CRYPTODEV: Initialisation parameters - name: 0000:c5:01.0_qat_sym,socket id: 0, max queue pairs: 0
CRYPTODEV: Creating cryptodev 0000:c5:01.0_qat_asym
CRYPTODEV: Initialisation parameters - name: 0000:c5:01.0_qat_asym,socket id: 0, max queue pairs: 0
CRYPTODEV: Creating cryptodev crypto_scheduler_pmd_1
CRYPTODEV: Initialisation parameters - name: crypto_scheduler_pmd_1,socket id: 0, max queue pairs: 8
cryptodev_scheduler_create() line 135:   Scheduling mode = round-robin
cryptodev_scheduler_create() line 190:   Packet ordering = disable
Allocated pool "priv_sess_mp_0" on socket 0
CRYPTODEV: elt_size 0 is expanded to 384
Allocated pool "sess_mp_0" on socket 0
    lcore id    Buf Size  Burst Size    Enqueued    Dequeued  Failed Enq  Failed Deq        MOps        Gbps  Cycles/Buf

           2          64          32    30000000    30000000    40796324    35512685      6.7107      3.4359      327.83
           2         128          32    30000000    30000000    39185655    33510300      6.4670      6.6223      340.19
           2         256          32    30000000    30000000    35293061    28902661      6.4598     13.2297      340.57
           2         512          32    30000000    30000000    32060727    24464394      6.4967     26.6105      338.63
           2        1024          32    30000000    30000000    51840454    42292847      4.7365     38.8013      464.48
           2        2048          32    30000000    30000000   170980805   163077263      2.5391     41.6004      866.45

===

ubuntu@xeon-sm-01:~/dpdk-qat-test$ ./run-test.sh 

sudo /home/ubuntu/dpdk-stable-21.11.4/build/x86_64-native-linuxapp-gcc/app//dpdk-test-crypto-perf   -l 1-2 -a 0000:c5:01.0   -- --devtype crypto_qat   --buffer-sz 64,128,256,512,1024,2048 --cipher-algo aes-cbc   --cipher-key-sz 16 --cipher-iv-sz 16 --cipher-op encrypt --optype cipher-only   --burst-sz 32 --silent --ptest throughput --total-ops 3000000
EAL: Detected CPU lcores: 64
EAL: Detected NUMA nodes: 1
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
EAL: Selected IOVA mode 'PA'
EAL: No available 2048 kB hugepages reported
EAL: VFIO support initialized
EAL: Using IOMMU type 1 (Type 1)
EAL: Probe PCI driver: qat (8086:37c9) device: 0000:c5:01.0 (socket 0)
CRYPTODEV: Creating cryptodev 0000:c5:01.0_qat_sym
CRYPTODEV: Initialisation parameters - name: 0000:c5:01.0_qat_sym,socket id: 0, max queue pairs: 0
CRYPTODEV: Creating cryptodev 0000:c5:01.0_qat_asym
CRYPTODEV: Initialisation parameters - name: 0000:c5:01.0_qat_asym,socket id: 0, max queue pairs: 0
Allocated pool "priv_sess_mp_0" on socket 0
CRYPTODEV: elt_size 0 is expanded to 384
Allocated pool "sess_mp_0" on socket 0
    lcore id    Buf Size  Burst Size    Enqueued    Dequeued  Failed Enq  Failed Deq        MOps        Gbps  Cycles/Buf

           2          64          32    30000000    30000000    35236778    31004418      8.3687      4.2848      262.88
           2         128          32    30000000    30000000    34554623    30118915      8.3268      8.5266      264.21
           2         256          32    30000000    30000000    35073701    30032106      8.1284     16.6469      270.66
           2         512          32    30000000    30000000    33916787    27510819      7.6092     31.1674      289.12
           2        1024          32    30000000    30000000    55240703    46462589      5.5251     45.2616      398.18
           2        2048          32    30000000    30000000   192426323   184965515      2.6587     43.5601      827.47

===

ubuntu@xeon-sm-01:~/dpdk-qat-test$ ./run-test.sh 
sudo /home/ubuntu/dpdk-stable-21.11.4/build/x86_64-native-linuxapp-gcc/app//dpdk-test-crypto-perf   -l 1-2 -a 0000:c5:01.0   -- --devtype crypto_qat   --buffer-sz 64,128,256,512,1024,2048 --cipher-algo aes-cbc   --cipher-key-sz 16 --cipher-iv-sz 16 --cipher-op encrypt --optype cipher-only   --burst-sz 32 --silent --ptest throughput --total-ops 3000000
EAL: Detected CPU lcores: 64
EAL: Detected NUMA nodes: 1
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
EAL: Selected IOVA mode 'PA'
EAL: No available 2048 kB hugepages reported
EAL: VFIO support initialized
EAL: Using IOMMU type 1 (Type 1)
EAL: Probe PCI driver: qat (8086:37c9) device: 0000:c5:01.0 (socket 0)
CRYPTODEV: Creating cryptodev 0000:c5:01.0_qat_sym
CRYPTODEV: Initialisation parameters - name: 0000:c5:01.0_qat_sym,socket id: 0, max queue pairs: 0
CRYPTODEV: Creating cryptodev 0000:c5:01.0_qat_asym
CRYPTODEV: Initialisation parameters - name: 0000:c5:01.0_qat_asym,socket id: 0, max queue pairs: 0
Allocated pool "priv_sess_mp_0" on socket 0
CRYPTODEV: elt_size 0 is expanded to 384
Allocated pool "sess_mp_0" on socket 0
    lcore id    Buf Size  Burst Size    Enqueued    Dequeued  Failed Enq  Failed Deq        MOps        Gbps  Cycles/Buf

           2          64          32    30000000    30000000    35707379    31457493      8.3489      4.2746      263.51
           2         128          32    30000000    30000000    34876650    30463354      8.3286      8.5285      264.15
           2         256          32    30000000    30000000    35098140    30047386      8.1308     16.6519      270.58
           2         512          32    30000000    30000000    33854650    27443156      7.6107     31.1733      289.07
           2        1024          32    30000000    30000000    55257589    46470174      5.5247     45.2586      398.21
           2        2048          32    30000000    30000000   192056856   184586902      2.6627     43.6258      826.23

sudo /home/ubuntu/dpdk-stable-21.11.4/build/x86_64-native-linuxapp-gcc/app//dpdk-test-crypto-perf   -l 2-3 -a 0000:c5:01.0   -- --devtype crypto_qat   --buffer-sz 64,128,256,512,1024,2048 --cipher-algo aes-cbc   --cipher-key-sz 16 --cipher-iv-sz 16 --cipher-op encrypt --optype cipher-then-auth   --auth-op generate --digest-sz 20 --auth-algo sha1-hmac --auth-key-sz 64   --burst-sz 32 --silent --ptest throughput --total-ops 30000000
EAL: Detected CPU lcores: 64
EAL: Detected NUMA nodes: 1
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
EAL: Selected IOVA mode 'PA'
EAL: No available 2048 kB hugepages reported
EAL: VFIO support initialized
EAL: Using IOMMU type 1 (Type 1)
EAL: Probe PCI driver: qat (8086:37c9) device: 0000:c5:01.0 (socket 0)
CRYPTODEV: Creating cryptodev 0000:c5:01.0_qat_sym
CRYPTODEV: Initialisation parameters - name: 0000:c5:01.0_qat_sym,socket id: 0, max queue pairs: 0
CRYPTODEV: Creating cryptodev 0000:c5:01.0_qat_asym
CRYPTODEV: Initialisation parameters - name: 0000:c5:01.0_qat_asym,socket id: 0, max queue pairs: 0
Allocated pool "priv_sess_mp_0" on socket 0
CRYPTODEV: elt_size 0 is expanded to 384
Allocated pool "sess_mp_0" on socket 0
    lcore id    Buf Size  Burst Size    Enqueued    Dequeued  Failed Enq  Failed Deq        MOps        Gbps  Cycles/Buf

           3          64          32    30000000    30000000    49988046    43823248      6.1343      3.1407      358.64
           3         128          32    30000000    30000000    51799960    45687077      6.0581      6.2035      363.15
           3         256          32    30000000    30000000    55429814    49256897      5.8709     12.0236      374.73
           3         512          32    30000000    30000000    62930793    56890592      5.5288     22.6460      397.92
           3        1024          32    30000000    30000000    94872722    88654874      4.3542     35.6696      505.26
           3        2048          32    30000000    30000000   197274566   190581334      2.6067     42.7087      843.97

===

ubuntu@xeon-sm-01:~/dpdk-qat-test$ ./run-test.sh 2
sudo /home/ubuntu/dpdk-stable-21.11.4/build/x86_64-native-linuxapp-gcc/app//dpdk-test-crypto-perf                 -l 2-3 -a 0000:c5:01.0                  --vdev crypto_aesni_mb                  -- --devtype crypto_aesni_mb            --buffer-sz 64,128,256,512,1024,2048 --cipher-algo aes-cbc                 --cipher-key-sz 16 --cipher-iv-sz 16 --cipher-op encrypt --optype cipher-then-auth              --auth-op generate --digest-sz 12 --auth-algo sha1-hmac --auth-key-sz 64          --burst-sz 32 --silent --ptest throughput --total-ops 30000000 --csv-friendly
EAL: Detected CPU lcores: 64
EAL: Detected NUMA nodes: 1
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
EAL: Selected IOVA mode 'PA'
EAL: No available 2048 kB hugepages reported
EAL: VFIO support initialized
EAL: Using IOMMU type 1 (Type 1)
EAL: Probe PCI driver: qat (8086:37c9) device: 0000:c5:01.0 (socket 0)
CRYPTODEV: Creating cryptodev 0000:c5:01.0_qat_sym
CRYPTODEV: Initialisation parameters - name: 0000:c5:01.0_qat_sym,socket id: 0, max queue pairs: 0
CRYPTODEV: Creating cryptodev 0000:c5:01.0_qat_asym
CRYPTODEV: Initialisation parameters - name: 0000:c5:01.0_qat_asym,socket id: 0, max queue pairs: 0
CRYPTODEV: Creating cryptodev crypto_aesni_mb
CRYPTODEV: Initialisation parameters - name: crypto_aesni_mb,socket id: 0, max queue pairs: 8
ipsec_mb_create() line 139: IPSec Multi-buffer library version used: 1.2.0

Allocated pool "priv_sess_mp_0" on socket 0
CRYPTODEV: elt_size 0 is expanded to 384
Allocated pool "sess_mp_0" on socket 0
    lcore id    Buf Size  Burst Size    Enqueued    Dequeued  Failed Enq  Failed Deq        MOps        Gbps  Cycles/Buf

           3          64          32    30000000    30000000           0           0      6.2125      3.1808      354.12
           3         128          32    30000000    30000000           0           0      5.5515      5.6847      396.29
           3         256          32    30000000    30000000           0           0      4.5995      9.4198      478.31
           3         512          32    30000000    30000000           0           0      3.4213     14.0136      643.03
           3        1024          32    30000000    30000000           0           0      2.2651     18.5554      971.27
           3        2048          32    30000000    30000000           0           0      1.3468     22.0662     1633.48

===



If you could get in touch with Intel DPDK QAT folks, that would be great. Hope to close the gap soon.


Thanks and Best!

JCK

