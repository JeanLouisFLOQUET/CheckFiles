@echo off

set list=
set list=%list% .\c\config.h
set list=%list% .\c\md2.h
set list=%list% .\c\md2.c
set list=%list% .\c\md4.h
set list=%list% .\c\md4.c
set list=%list% .\c\md5.h
set list=%list% .\c\md5.c
set list=%list% .\c\sha1.h
set list=%list% .\c\sha1.c
set list=%list% .\c\sha2.h
set list=%list% .\c\sha2.c
set list=%list% .\c\sha4.h
set list=%list% .\c\sha4.c

set path_32=C:\MinGW32\bin\
set path_64=C:\MinGW64\bin\
set dll_32=CheckFiles_x86.dll
set dll_64=CheckFiles_x64.dll
echo ==================================================================================
if exist %dll_32% ( attrib -h -r -s %dll_32% )
if exist %dll_64% ( attrib -h -r -s %dll_64% )

echo Compiling x86.dll
%path_32%gcc.exe -O2 -lm -mdll -m32 %list% -o %dll_32%

rem echo Compiling x64.dll
rem %path_64%x86_64-w64-mingw32-gcc.exe -O2 -lm -mdll -m64 %list% -o %dll_64%
echo ==================================================================================
