modprobe ipmi_devintf
# sudo modprobe drm_kms_helper
# modprobe ipmi_msghandler
insmod /lib/modules/4.20.7-gnu/video/nvidia.ko
insmod /lib/modules/4.20.7-gnu/video/nvidia-modeset.ko
insmod /lib/modules/4.20.7-gnu/video/nvidia-drm.ko
insmod /lib/modules/4.20.7-gnu/video/nvidia-uvm.ko
