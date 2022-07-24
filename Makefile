all: rom

rom:
	dd bs=1024 count=1024 if=/dev/zero of=combined.bin
	dd bs=1 if=z8kboot/z8kmon/z8kload.bin of=combined.bin seek=983040 conv=notrunc
	dd bs=1 if=z8kboot/z8kmon/z8kmon.bin of=combined.bin seek=983552 conv=notrunc
	python bsplit.py combined.bin low.bin hi.bin

