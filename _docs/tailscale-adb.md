
on phone (rooted termux):

```sh
setprop persist.adb.tcp.port 5555
```

```sh
adb connect --tcpip=<tailscale-ip>:5555
```
