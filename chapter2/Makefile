boot_dir := ./
BIN := boot.bin


boot.o : $(boot_dir)boot.asm
	nasm $(boot_dir)boot.asm -o $(boot_dir)boot.o

$(BIN) : $(boot_dir)boot.o
	cp $(boot_dir)boot.o $(boot_dir)boot.bin


.PHONY : qemu clean
qemu : boot.bin
	qemu-system-i386 $(boot_dir)boot.bin
debug : boot.bin
	qemu-system-i386 -S -s $(boot_dir)boot.bin
clean :
	rm $(boot_dir)boot.bin
	rm $(boot_dir)boot.o
