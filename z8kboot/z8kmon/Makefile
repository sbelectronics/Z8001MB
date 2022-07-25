# makefile for z8kmon

AS = z8k-coff-as
LD = z8k-coff-ld
OBJCOPY = z8k-coff-objcopy

.SUFFIXES: .o .s 

objs = z8kmon.o cpu.o conio.o z8530.o ide.o\
		dcmnd.o scmnd.o gcmnd.o lcmnd.o iocmnd.o zcmnd.o bcmnd.o

bootobjs = loader.o

.PHONY: all
all: z8kmon.bin z8kload.bin

z8kmon.bin: $(objs) z8001mb.x
	$(LD) -mz8001 -T z8001mb.x -o z8kmon $(objs)
	$(OBJCOPY) -O binary z8kmon z8kmon.bin

z8kload.bin: $(bootobjs) z8001mb.x
	$(LD) -mz8001 -T z8001mb.x -o z8kload $(bootobjs)
	$(OBJCOPY) -O binary z8kload z8kload.bin

.s.o:
	$(AS) -a=$<.lst -o $@ $< 

.PHONY: clean
clean:
	$(RM) -f z8kmon.bin z8kmon z8kload.bin z8kload $(objs)
