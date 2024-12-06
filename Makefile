BPFTOOL_COMMIT='77a72987353fcae8ce330fd87d4c7afb7677a169'


BASEDIR=$(PWD)
CFLAGS=-g -O2 -Wall -Wno-compare-distinct-pointer-types -D__TARGET_ARCH_x86 -mcpu=v3 -mlittle-endian -target bpf
IFLAGS=-idirafter /usr/lib/clang/18/include -idirafter /usr/local/include -idirafter/usr/include
IFLAGS+= -I$(PWD)/libbpf/include -I$(PWD)/libbpf/include/linux -I$(PWD)/libbpf/include/uapi -Iinclude -Iinclude/arch/x86 -Iinclude/bpf-compat
IFLAGS+= -I$(PWD)/bpftool/src/libbpf/include

test_good: clean bpftool_good objects test
test_bad: clean bpftool_bad objects test

bpftool_good:
	./fetch_bpftool

bpftool_bad: 
	./fetch_bpftool $(BPFTOOL_COMMIT)

objects: main.bpf.o util.bpf.o

%.bpf.o: %.bpf.c
	clang $(CFLAGS) $(IFLAGS) -o $@ -c $^

test:
	./bpftool/src/bpftool gen object lib.bpf.o main.bpf.o util.bpf.o

clean:
	rm -rf bpftool libbpf *.bpf.o

