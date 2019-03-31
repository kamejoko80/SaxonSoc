* Build instructions *

get source code =>

git clone https://github.com/kamejoko80/VexRiscv.git

git clone https://github.com/kamejoko80/SaxonSoc.git

cd SaxonSoc

git checkout SaxonUp5kEvn

generate verilog =>

make saxonUp5kEvn_verilog_gen

synthesize and program bitstream =>

make saxonUp5kEvn_prog_icecube2

compile and flash led blinky demo =>

make saxonUp5kEvn_prog_blinkAndEcho

openocd =>

https://github.com/SpinalHDL/openocd_riscv.git

openocd for simulation

src/openocd -f tcl/interface/jtag_tcp.cfg -c 'set SAXON_CPU0_YAML ../SaxonSoc/cpu0.yaml' -f tcl/target/saxon_xip.cfg


Zephyr build =>

git clone https://github.com/SpinalHDL/zephyr.git -b vexriscv

cd zephyr

unset ZEPHYR_GCC_VARIANT

unset ZEPHYR_SDK_INSTALL_DIR

export CROSS_COMPILE="/opt/riscv/bin/riscv64-unknown-elf-"

export ZEPHYR_TOOLCHAIN_VARIANT="cross-compile"

export ZEPHYR_GCC_VARIANT="cross-compile"

source zephyr-env.sh

cd samples/philosophers

mkdir build

cd build

cmake -DBOARD=vexriscv_saxon_up5k_evn ..

make -j${nproc}