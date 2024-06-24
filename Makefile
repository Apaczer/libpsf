PREFIX	?= /usr
CC		 = $(CROSS_COMPILE)gcc
STRIP	 = $(CROSS_COMPILE)strip
AR		 = $(CROSS_COMPILE)ar
RANLIB	 = $(SYSROOT)/../bin/ranlib
CFLAGS	?= -O3
INCLUDES = -I$(SYSROOT)$(PREFIX)/include
LDFLAGS	 = -L$(SYSROOT)$(PREFIX)/lib -lSDL -lpsf -lz

all: libpsf.so libpsf.a

%.so: libpsf.o
	$(CC) $(CFLAGS) -shared -fPIC $< -o $@

%.a: libpsf.c
	$(CC) $(CFLAGS) -c $< -o libpsf.o
	$(AR) q $@ libpsf.o
	$(RANLIB) $@

%.o: %.c
	$(CC) $(CFLAGS) -fPIC -c $< -o $@

example:
	$(CC) $(CFLAGS) showpsf.c -o showpsf $(INCLUDES) $(LDFLAGS)

example-dist: example
	mkdir -p dist/libs
	cp showpsf showpsf.sh dist/
	cp libpsf.so dist/libs/

install:
	$(STRIP) ./libpsf.so ./libpsf.a
	cp ./libpsf.so ./libpsf.a $(SYSROOT)$(PREFIX)/lib
	install ./psf.h $(SYSROOT)$(PREFIX)/include/psf.h

uninstall:
	rm $(SYSROOT)$(PREFIX)/lib/libpsf.so
	rm $(SYSROOT)$(PREFIX)/lib/libpsf.a
	rm $(SYSROOT)$(PREFIX)/include/psf.h

clean:
	rm ./libpsf.so
	rm ./libpsf.a
	-rm showpsf


phony: all install clean uninstall
