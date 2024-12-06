LIBBPF_COMMIT= '686f600bca59e107af4040d0838ca2b02c14ff50'
BPFTOOL_COMMIT='77a72987353fcae8ce330fd87d4c7afb7677a169'

BASEDIR=$(PWD)
CFLAGS=-g -O2 -Wall -Wno-compare-distinct-pointer-types -D__TARGET_ARCH_x86 -mcpu=v3 -mlittle-endian -target bpf
IFLAGS=-idirafter /usr/lib/clang/18/include -idirafter /usr/local/include -idirafter/usr/include
IFLAGS+= -I$(PWD)/libbpf/include -I$(PWD)/libbpf/include/linux -I$(PWD)/libbpf/include/uapi -Iinclude -Iinclude/arch/x86 -Iinclude/bpf-compat
IFLAGS+= -I$(PWD)/bpftool/src/libbpf/include

all: objects

libbpf:
	./fetch_libbpf libbpf $(LIBBPF_COMMIT)

bpftool:
	./fetch_bpftool bpftool $(BPFTOOL_COMMIT)

objects: timer.bpf.o main.bpf.o util.bpf.o

%.bpf.o: %.bpf.c
	clang $(CFLAGS) $(IFLAGS) -o $@ -c $^

clean:
	rm -rf bpftool libbpf *.bpf.o

