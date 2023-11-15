# xrdp-overlay
gentoo portage overlay for xrdp

## For satisfying audio streaming recommend following settings in /etc/xrdp/xrdp.ini:
```
tcp_send_buffer_bytes=4194304
crypt_level = low
```
Connecting with 16bpp should also slightly help.
