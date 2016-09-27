CC ?= gcc
CFLAGS_common ?= -Wall -std=gnu99 -g -DDEBUG
CFLAGS_iteration = -O0
CFLAGS_binary  = -O0
CFLAGS_byte  = -O0
CFLAGS_harlay  = -O0
CFLAGS_recursive  = -O0
ifeq ($(strip $(PROFILE)),1)
CFLAGS_common += -Dcorrect
endif
EXEC = iteration binary byte recursive harley
all: $(EXEC)

SRCS_common = main.c

iteration: $(SRCS_common) iteration.c clz.h
	$(CC) $(CFLAGS_common) $(CFLAGS_iteration) \
		-o $@ -Diteration $(SRCS_common) $@.c

binary: $(SRCS_common) binary.c clz.h
	$(CC) $(CFLAGS_common) $(CFLAGS_binary) \
		-o $@ -Dbinary $(SRCS_common) $@.c

byte: $(SRCS_common) byte.c clz.h
	$(CC) $(CFLAGS_common) $(CFLAGS_byte) \
		-o $@ -Dbyte $(SRCS_common) $@.c

harley: $(SRCS_common) harley.c clz.h
	$(CC) $(CFLAGS_common) $(CFLAGS_harley) \
		-o $@ -Dharley $(SRCS_common) $@.c

recursive: $(SRCS_common) recursive.c clz.hpp
	gcc  $(CFLAGS_common) $(CFLAGS_recursive) \
		-o $@ -Drecursive $(SRCS_common) $@.c

run:$(EXEC)
	./iteration 0 100
	./binary 0 100000
	./byte 0 100000
	./recursive 0 100000
	./harley 0 100000

plot:iteration.txt
	gnuplot scripts/runtime.gp


.PHONY: clean
clean:
	$(RM) $(EXEC) *.o *.txt *.png
