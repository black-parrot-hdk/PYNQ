
## Building a PYNQ image
PYNQ already provides <a href="http://www.pynq.io/board.html" target="_blank">prebuilt images</a> that you can download and write to the SD card without any modifications, but you can also build your own image and make modifications to it in the build process. 

The general flow is descibed <a href="https://pynq.readthedocs.io/en/v2.6.1/pynq_sd_card.html" target="_blank">here</a>, but since this process takes several hours here I'll try to highlight some notes to build it faster and without any errors. Also take note that I've tested the flow on the release v2.6.0, but the following should be helpful for other versions too.

## Before running make
First, you need to make sure you're using an "Ubuntu 18.04" or "Ubuntu 16.04" system with sudo access because many steps in this flow rely on these conditions.
Next, before starting the build process, you need to install some Xilinx tools(specificly PetaLinux, Vitis and Vivado). It's important to install the exact versions that are compatible with the image version described in the table <a href="https://pynq.readthedocs.io/en/v2.6.1/pynq_sd_card.html#use-vagrant-to-prepare-ubuntu-os" target="_blank">here</a>. For image v2.6.0, you have to install the 2020.1 Xilinx tools.

Also to skip the board-agnostic part of the build process, as described <a href="https://pynq.readthedocs.io/en/v2.6.1/pynq_sd_card.html#using-the-prebuilt-board-agnostic-image" target="_blank">here</a>, you can download the prebuilt Linux rootfs for your board's ARM architecture("arm" for PYNQ-Z2) and point the makefile to its location with the PREBUILT flag.

Another big step to save time is to pre-download the <a href="https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/embedded-design-tools/2020-1.html" target="_blank">PetaLinux cache</a>. For the specific Xilinx version you need to download the architecure-dependent "sstate-cache" and the architecture-agnostic "downloads" directory. The README file in the Xilinx download page describes how and where to install these files. This will save you time during the PetaLinux build step and you don't need to re-download these files everytime you run make.

Last thing is that after you run the setup\_host script as described <a href="https://pynq.readthedocs.io/en/v2.6.1/pynq_sd_card.html#use-existing-ubuntu-os" target="_blank">here</a>, run "sudo update-binfmts --display" and make sure that qemu for your ARM architecure is marked as enabled. If not manually enable it by running for example "sudo update-binfmts --enable qemu-arm".

## Build the image
Now you can run "make PREBUILT=\<path\>" to build your PYNQ image. This will still take a few hours to complete so make sure you have around 50-100 GBs of free disk space and enough RAM. In any step if you face an error you can "make delete" and resume that step after fixing the problem. 

Also during the boot\_files step if your system is having troubles fetching the "qemu-xilinx-native" package, you can kill the build, modify the file mentioned  <a href="https://forums.xilinx.com/t5/Embedded-Linux/qemu-fails-in-petalinux-buld-due-to-Fetcher-failure/m-p/1196809/highlight/true#M48172" target="_blank">here</a> and resume the built after running "make delete".
