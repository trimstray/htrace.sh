---
layout: default
---

<p align="center">
  <a href="https://github.com/trimstray/htrace.sh">
    <img src="https://trimstray.github.io/htrace.sh/assets/img/htrace.sh_logo.png" alt="Master">
  </a>
</p>

## About Project

**[htrace.sh](https://github.com/trimstray/htrace.sh)** is a shell script for http/https troubleshooting and profiling. It's also a simple wrapper around several open source security tools.

Several functions of this script:

- check **website/domain configuration** (web servers or reverse proxies)
- display basic information about HTTP/HTTPS protocols including **URLs, GeoIP, status codes and protocol version**
- check **HTTP request latency** (`time_connect` and `time_total`)
- **redirects analysis** (and follows it), e.g. to eliminate redirect loops
- view and analyze **response headers** for each request
  - try **bypassing cache** (e.g Varnish Cache)
- view and analyze **response body** for each request
- view setting HTTP **request method** and **headers**
- check **basic ssl** configuration
  - **validation** of the certificates (e.g. `date`, `cn`, `san`)
  - check the **Chain of Trust**
  - check the **Server Name Indication**
  - **verification** ssl connection
- test extended ssl configuration (protocols and ciphers) with **testssl.sh**
- scan website for **Mixed Content** (non-secure resources)
- scan website and domain using **Nmap NSE Library** (40 scripts)
  - support advanced vulnerability scanning with [Vulscan](https://github.com/scipag/vulscan)
- analyze website with **Mozilla Observatory**
- deep analysis of the ssl web server with **SSL Labs API**
- detect and bypass web application firewalls with **wafw00f**
- enumerate subdomains of website with **SubFinder**
  - perform zone transfer attack (with `api.hackertarget.com` or `dig`)
- test HTTP/2 connection with **nghttp2**

## Preview

<p align="center">
    <img src="https://trimstray.github.io/htrace.sh/assets/img/htrace.sh_preview.png"
        alt="Master">
</p>

## About Me

I'm a System and (tiny) Network Administrator. Also Security Enthusiast.

For the most part, I manage environments based on GNU/Linux and BSD systems.

The postings on this domain are my own and don't necessarily represent my employer’s positions, strategies or opinions.

## Contact

If you wish to contact me:

- via e-mail (base64): `dHJpbXN0cmF5QGdtYWlsLmNvbQo=`
