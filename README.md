# NightShifter

![screenshot](https://github.com/elanini/NightShifter/raw/master/screenshot.png "Screenshot")

this is a simple menubar application for changing the current warmth of your
mac. 

The release is tested and built against macOS 10.12.4.  It uses the
CoreBrightness private framework. Due to this fact, it may not work on any other
OS than 10.12.4. If it does work elsewhere, let me know, and I'll put
it in the readme. The feature was only added in 10.12.4 so if it can work it
will only be on later OS version. 

Feel free to contribute. 


## Using it
There are releases in the releases tab. 
The app is not officially signed so you will need to do some dancing around Gatekeeper.
Some info [here](https://www.imore.com/how-open-apps-unidentified-developers-mac) (first link I found). 

## Command line
run with `./shifter`, add it to your path to run anywhere.
```
$ ./shifter get #returns current setting as integer * 100
$ ./shifter set 50 # set warmth level to 50%, 0.5
$ ./shifter on
$ ./shifter off
```

## internals
I used frida to track down the calls System Preferences makes, figured out which
framework has those classes, and class-dumped it. I included a partial header
for CBBlueLightClient which contains the methods I use. 
