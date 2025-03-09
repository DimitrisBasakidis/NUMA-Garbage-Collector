CC = gcc
CFLAGS = -Wall -Wextra -O2
DEFINES = -D_GNU_SOURCE

# Targets
all: numa_alloc 

util.o: 
	$(CC) $(CFLAGS) $(DEFINES) -c util.c

numa.o: numa.c
	$(CC) $(CFLAGS) -c numa.c

allocator.o: numa.o
	$(CC) $(CFLAGS) $(DEFINES) -c allocator.c 

numa_alloc: allocator.o numa.o util.o
	$(CC) $(DEFINES) $(CFLAGS) main.c allocator.o numa.o util.o -o numa_alloc -pthread -lm
	g++ cpp_allocator.cpp -c
	g++ main.cpp numa.o util.o allocator.o cpp_allocator.o -o cpp_alloc


clean:
	rm -f *.o numa_alloc
