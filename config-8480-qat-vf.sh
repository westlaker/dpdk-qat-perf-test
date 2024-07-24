sudo modprobe vfio-pci
# intel
#echo "16" | sudo tee /sys/bus/pci/drivers/c6xx/0000\:c5\:00.0/sriov_numvfs
#echo "16" | sudo tee /sys/bus/pci/drivers/c6xx/0000\:c6\:00.0/sriov_numvfs
#echo "16" | sudo tee /sys/bus/pci/drivers/c6xx/0000\:c7\:00.0/sriov_numvfs

# intel SPR Xeon 8480+
echo "16" | sudo tee /sys/bus/pci/drivers/4xxx/0000\:6b\:00.0/sriov_numvfs
echo "16" | sudo tee /sys/bus/pci/drivers/4xxx/0000\:e8\:00.0/sriov_numvfs

# arm
#echo "16" | sudo tee /sys/bus/pci/drivers/c6xx/000c\:03\:00.0/sriov_numvfs
#echo "16" | sudo tee /sys/bus/pci/drivers/c6xx/000c\:04\:00.0/sriov_numvfs
#echo "16" | sudo tee /sys/bus/pci/drivers/c6xx/000c\:05\:00.0/sriov_numvfs


