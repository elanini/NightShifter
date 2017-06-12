# NightShifter

![screenshot](https://github.com/elanini/NightShifter/raw/master/screenshot.png "Screenshot")

this is a simple menubar application for changing the current warmth of your
mac. 

The release is tested and built against macOS 10.12.4.  It uses the
CoreBrightness private framework. Due to this fact, it may not work on any other
OS than 10.12, or 10.12.4. If it does work elsewhere, let me know, and I'll put
it in the readme. It may work to build it yourself, linking against your own
copy of CoreBrightness.

Feel free to contribute. 

## internals
I used frida to track down the calls System Preferences makes, figured out which
framework has those classes, and class-dumped it. I included a partial header
for CBBlueLightClient which contains the methods I use. 
