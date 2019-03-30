ZEPHYR=../zephyr/zephyrSpinalHdl
SHELL=/bin/bash
NETLIST_DEPENDENCIES=$(shell find hardware/scala -type f)
.ONESHELL:
ROOT=$(shell pwd)

saxonUp5kEvn_verilog_gen:
	sbt "runMain saxon.SaxonUp5kEvn"

saxonUp5kEvn_prog_icecube2: hardware/synthesis/icestorm/SaxonUp5kEvn.bin 

saxonUp5kEvn_prog_blinkAndEcho: software/standalone/blinkAndEcho/build/blinkAndEcho.bin
	iceprog -o 0x100000 software/standalone/blinkAndEcho/build/blinkAndEcho.bin
    
saxonUp5kEvn_prog_dhrystone: software/standalone/dhrystone/build/dhrystone.bin
	iceprog -o 0x100000 software/standalone/dhrystone/build/dhrystone.bin 

saxonUp5kEvn_prog_demo: software/bootloader
	iceprog -o 0x100000 software/bootloader/up5kEvnDemo.bin

.PHONY: hardware/synthesis/icestorm/SaxonUp5kEvn.bin
hardware/synthesis/icestorm/SaxonUp5kEvn.bin:
	make -C hardware/synthesis/icestorm prog -j$(nproc)

.PHONY: software/standalone/blinkAndEcho/build/blinkAndEcho.bin
software/standalone/blinkAndEcho/build/blinkAndEcho.bin:
	source ${ZEPHYR}/zephyr-env.sh
	make -C software/standalone/blinkAndEcho all

.PHONY: software/standalone/dhrystone/build/dhrystone.bin
software/standalone/dhrystone/build/dhrystone.bin:
	source ${ZEPHYR}/zephyr-env.sh
	make -C software/standalone/dhrystone all

.PHONY: software/bootloader
software/bootloader:
	source ${ZEPHYR}/zephyr-env.sh
	make -C software/bootloader all
