## Firmware for SCMD-2 MCU

This is a firmware for SCMD-2 (ATmega328P MCU with 16MHz external crystal
oscillator), formatted as [CodeVisionAVR](http://www.hpinfotech.ro/) project.

For SCMD-2 schematic navigate [here](https://github.com/SCMD/schematic).

### Fuse bits setup for ATmega328P
* CKSEL3..1 = 111 (freq. range 8.0 - 16.0 MHz)
* CKSEL0 = 1, SUT1..0 = 11 (Crystal Oscillator, slowly rising power)
* CKDIV8 = 1 (no freq. division)

## License

SCMD firmware is a part of Skin Conductance Measuring Device.

Copyright (C) 2014, Centre for Decision Research and Experimental Economics
(CeDEx), the University of Nottingham.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.
