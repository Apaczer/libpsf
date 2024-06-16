## libpsf:
This is a simple library that can be used to read PSF format fonts (Linux console fonts). 
With this library, you can render text on the screen without using overly complicated TTF fonts. 
This library works with both type 1 and type 2 PSF fonts. It can also read gzipped fonts if built with zlib support (default).

Full credit to the original author → [prushik](https://github.com/prushik)
 better know as maintainer of betteros.org (no pun intended).

### Disclaimer:
This library is made to be useful for people who want to use it for what it was
meant to do. If you are not one of those people, then don't get mad.

# Intro:
The purpose of this library is to read files in the PC Screen Font format (PSF)
and prepare the data so that it can be displayed on the screen.
PC Screen Fonts are very useful fonts, particularly on Linux machines. Because
PSF is a bitmap font format, it is not scalable, and hence not perfect for all
applications. However, it can be rendered much faster than vector fonts and most
applications do not require font scaling. Plus, on Linux computers, these fonts
are already present (Linux Console Fonts), meaning that they do not need to be
distributed with your Linux software. Also, the format is very simple can be
read with low overhead, which is what this library aims to do.
This library is useful in applications such as small game. since these typically 
do not require scalable fonts. Many other lightweight applications may benefit 
from this library as well due to its small size and simplicity.


# Caveats:
Linux Console Fonts are typically gzipped, so the library must be built with
zlib support in order to work with some stock Linux distributions (Ubuntu).


# Building and Installing:
### Building & installing is simple
- native
```
make
make install
```
- cross-compile
```
export CC=${CROSS_COMPILE}gcc
make
cp libpsf.so ${SYSROOT}/usr/lib #on host to build & target to run
```

If you wish to install in a different location, use the PREFIX environment
variable while installing.
If you want to build without zlib support, then add "-DNO_ZLIB" to the CFLAGS
environment variable while compiling.

If you wish to compile without libc support, add "-DNO_CLIB" to CFLAGS. This 
requires disabling zlib as well. This assumes you have an implementation of 
several functions including memcpy and several syscall functions. Examples are
included in amd64_syscalls.s and mem.s, although some versions of gcc also 
provide a usable built-in memcpy implementation.

### Build an example to display psf font with SDL1.2 backend (showpsf.c):
- native
```
gcc showpsf.c -o showpsf -lSDL -lpsf -lz
```
- cross-compile
```
${CROSS_COMPILE}gcc showpsf.c -o showpsf -I{SYSROOT/usr/lib -lSDL -lpsf -lz
```
Run binary:
```
./showpsf #use "font.psf" in CWD

--or--

./showpsf <font_name.psf> #pass [arg] as PSF font
```
# Using:
Include psf.h in your application. It is possible to link dynamically, but 
this is not recommended for releases, linking statically or including 
libpsf.c in your project is the recommended usage since it avoids adding a 
runtime dependency.

API documentation is found in the file called API.
