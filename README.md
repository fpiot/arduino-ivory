# Ivory programing on Arduino

## Demo code

The Ivory code is found at following:

* [Example 01: Blinking LED](./demo/01_blink/MainIvory.hs)

## Hardware: [Arduino Uno](http://arduino.cc/en/Main/ArduinoBoardUno)

[![](_img/ArduinoUnoR3.jpg)](http://arduino.cc/en/Main/ArduinoBoardUno)

* CPU: ATmega328 ([Atmel AVR](http://www.atmel.com/products/microcontrollers/avr/) 8-bit)
* Flash ROM: 32 kB
* SRAM: 2 kB

Also you could get [compatible boards](http://www.sainsmart.com/arduino/control-boards/sainsmart-uno-atmega328p-pu-atmega8u2-microcontroller-for-arduino.html)


## Setup environment

### [Debian GNU/Linux](https://www.debian.org/)

Install some packages.

```
$ sudo vi /etc/apt/preferences.d/avr
Package: avrdude
Pin: version 6.1*
Pin-Priority: 1001
$ sudo apt-get install binutils-avr gcc-avr avr-libc avrdude
```

### Mac OS X

Install AVR toolchain http://www.obdev.at/products/crosspack/index.html, and set PATH env.

```
$ export PATH=$PATH:/usr/local/CrossPack-AVR/bin
$ which avr-gcc
/usr/local/CrossPack-AVR/bin/avr-gcc
```

### Windows

Install following package on [cygwin](https://www.cygwin.com/).

* git
* make

Install AVR toolchain http://winavr.sourceforge.net/.

T.B.D.


## How to build

Install Ivory http://ivorylang.org/.

```
$ git clone https://github.com/GaloisInc/ivory.git
$ cd ivory
$ for i in ivory ivory-artifact ivory-opts ivory-backend-c ivory-eval ivory-stdlib ivory-examples ivory-hw ivory-model-check ivory-quickcheck ivory-serialize; do (cd $i && cabal install); done
```

Compile the Ivory source code for Arduino.

```
$ cd arduino-ivory/demo/01_blink/
$ make
$ file main.elf main.hex
main.elf: ELF 32-bit LSB executable, Atmel AVR 8-bit, version 1 (SYSV), statically linked, not stripped
main.hex: ASCII text, with CRLF line terminators
```


## Write to the flash

Connect Arduino board to your PC using USB cable.
And run following commands.

```
$ ls -l /dev/ttyACM0
crw-rw---- 1 root dialout 166, 0 May  8 15:59 /dev/ttyACM0
$ cd arduino-ivory/demo/01_blink/
$ make write
avrdude -c stk500v2 -p atmega2560 -b 115200 -P /dev/ttyACM0 -U flash:w:main.hex
avrdude: AVR device initialized and ready to accept instructions
Reading | ################################################## | 100% 0.01s
--snip--
avrdude: verifying ...
avrdude: 2850 bytes of flash verified
avrdude: safemode: Fuses OK (E:00, H:00, L:00)
avrdude done.  Thank you.
```


## How to debug using gdb

[![](_img/avr_dragon.jpg)](http://www.atmel.com/tools/avrdragon.aspx)

T.B.D.
