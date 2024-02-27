sudo modprobe vfio-pci
echo "16" | sudo tee /sys/bus/pci/drivers/c6xx/0000\:c5\:00.0/sriov_numvfs
echo "16" | sudo tee /sys/bus/pci/drivers/c6xx/0000\:c6\:00.0/sriov_numvfs
echo "16" | sudo tee /sys/bus/pci/drivers/c6xx/0000\:c7\:00.0/sriov_numvfs
