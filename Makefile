PROJECT = foo
CPU ?= cortex-m3
BOARD ?= stm32vldiscovery


qemu:
	arm-none-eabi-as -mthumb -mcpu=$(CPU) -ggdb -c $(PROJECT).S -o foo.o
	arm-none-eabi-ld -Tmap.ld foo.o -o foo.elf
	arm-none-eabi-objdump -D -S foo.elf > foo.elf.lst
	arm-none-eabi-readelf -a foo.elf > foo.elf.debug
	qemu-system-arm -S -M $(BOARD) -cpu $(CPU) -nographic -kernel $(PROJECT).elf -gdb tcp::1234

compileC:
	arm-none-eabi-gcc -mcpu=$(CPU) -mthumb -c $(PROJECT).c -o $(PROJECT).elf
	qemu-system-arm -S -M $(BOARD) -cpu $(CPU) -nographic -kernel $(PROJECT).elf -gdb tcp::1234

gdb:
	gdb-multiarch -q $(PROJECT).elf -ex "target remote localhost:1234"



clean:
	@rm -rf *.o *.out *.elf .gdb_history *.lst *.debug *.o



