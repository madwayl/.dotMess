showkey shows as `keycode 148`

and `sudo evtest` for input `/dev/input/event3:      AT Translated Set 2 keyboard` shows below:

```sh
Event: time 1777275537.513223, type 4 (EV_MSC), code 4 (MSC_SCAN), value d7
```

only scan code no keycode

from showkey:

```sh
$ grep -r '148' /usr/include/linux/input-event-codes.h
#define KEY_PROG1               148
#define BTN_TOOL_QUINTTAP       0x148   /* Five fingers on trackpad */
```

d7 scandeo from device input:

```sh
$ cat /sys/class/input/event3/device/modalias

input:b0011v0001p0001eAB83-e0,1,4,11,14,k71,72,73,74,75,76,77,79,7A,7B,7C,7D,7E,7F,80,8C,8E,8F,94,96,99,9C,9D,9E,9F,A1,A3,A4,A5,A6,AD,B7,B8,B9,BA,BB,BC,BD,BE,BF,C0,C1,CA,CB,D4,D7,D9,E0,E1,E2,ED,EE,F0,F8,1D1,212,ram4,l0,1,2,sfw
```

I see that the keycode - scancode is defined in `/usr/include/linux/input-event-codes.h` but not for the missing key

I have to create a custom hwdb file: `/etc/udev/hwdb.d/99-bluetooth-key.hwdb`, created below:

```md
evdev:atkbd:*
 KEYBOARD_KEY_d7=bluetooth
```

gives out the code finally from `evtest`:

```sh
Event: time 1777279093.800236, type 4 (EV_MSC), code 4 (MSC_SCAN), value d7
Event: time 1777279093.800236, type 1 (EV_KEY), code 148 (KEY_BLUETOOTH), value 0
```

Also updated in:

```sh
$ grep -r 'BLUETOOTH' /usr/share/X11/xkb/keycodes/
/usr/share/X11/xkb/keycodes/evdev:      <I245> = 245;           // #define KEY_BLUETOOTH           237
```

showkey shows as 237 (WTF) I guess I mapped it right - its the keycode

This could've restarted the layout: `localectl --no-convert set-x11-keymap us`
