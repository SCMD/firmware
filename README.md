##############################################################################
# Firmware for SCMD-2 MCU
##############################################################################

This is a firmware for SCMD-2 (ATmega328P MCU with 16MHz external crystal
oscillator), formatted as [CodeVisionAVR](http://www.hpinfotech.ro/) project.

### Fuse bits setup for ATmega328P
* CKSEL3..1 = 111 (freq. range 8.0 - 16.0 MHz)
* CKSEL0 = 1, SUT1..0 = 11 (Crystal Oscillator, slowly rising power)
* CKDIV8 = 1 (no freq. division)
