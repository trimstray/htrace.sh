<h1 align="left"><code>htrace.sh</code></h1>

<p align="left">
  <a href="https://travis-ci.org/trimstray/htrace.sh">
    <img src="https://travis-ci.org/trimstray/htrace.sh.svg?branch=master"
        alt="Travis-CI">
  </a>
  <a href="https://github.com/trimstray/htrace.sh/tree/master/build">
    <img src="https://img.shields.io/badge/Docker-Support-blue.svg"
        alt="Docker">
  </a>
</p>

<br>

<p align="center">
    <img src="https://github.com/trimstray/htrace.sh/blob/master/static/img/htrace.sh_preview.png"
        alt="Master">
</p>

<div align="center">
  <sub>Created by
  <a href="https://twitter.com/trimstray">trimstray</a> and
  <a href="https://github.com/trimstray/htrace.sh/graphs/contributors">
    contributors
  </a>
</div>

<br>

## Description

`htrace.sh` is a shell script for http/https troubleshooting and profiling. It's also a simple wrapper around several open source security tools.

For a more detailed understanding of `htrace.sh`, its parameters, functions and how it all works, see the **[Wiki](https://github.com/trimstray/htrace.sh/wiki)**.

## How To Use

To install `htrace.sh` itself:

```bash
# Clone this repository
git clone https://github.com/trimstray/htrace.sh

# Go into directory
cd htrace.sh

# Install
sudo ./setup.sh install

# Install dependencies (Debian 8/9, Ubuntu 18.x and MacOS support)
#   - recommend build docker image or install dependencies manually
#   - before init please see what it does and which packages are available on your repository
sudo ./dependencies.sh

# Run the app
htrace.sh -u https://nmap.org -s -h
```

> * symlink to `bin/htrace.sh` is placed in `/usr/local/bin`
> * man page is placed in `/usr/local/man/man8`

or build docker image:

```bash
# Clone this repository
git clone https://github.com/trimstray/htrace.sh

# Go into directory and build docker image
cd htrace.sh && build/build.sh

# Run the app
docker run --rm -it --name htrace.sh htrace.sh -u https://nmap.org -s -h
```

## Parameters

Provides the following options:

```
    htrace.sh v1.1.4

  Usage:

    htrace.sh <option|long-option>

  Examples:

    htrace.sh -u https://example.com --all-scans
    htrace.sh -u https://example.com -s -h --testssl --ssllabs
    htrace.sh -u https://example.com -h -M 'POST:password=123&name=Admin'
    htrace.sh --url https://example.com --cache-bypass "?${RANDOM}"
    htrace.sh --url https://example.com --ssl --headers --proxy "socks5h://127.0.0.1:9501"

  Options:

        --help                                show this message
        --version                             show script version

    Standard:

        -u|--url <value>                      set target url with http/https protocol
        -s|--ssl                              show basic ssl server/connection parameters
        -h|--headers                          show response headers
        -b|--body                             show response body
        -M|--req-method <value>               set request method (default: GET)
        -H|--req-header <value>               set request header(s)
        -p|--proxy <value>                    set proxy server (not for external tools)
        -r|--resolve <value>                  resolve the host+port to this address

    Security tools:

        --testssl                             test ssl protocols and ciphers (testssl.sh)
        --observatory                         analyze website headers (mozilla observatory)
        --ssllabs                             deep analysis of the ssl web server (ssllabs)
        --mixed-content                       scan website for non-secure resources (mixed-content-scan)
        --nse                                 scan website and domain with nse library (nmap)
        --waf                                 detect and bypass web application firewalls (whatwaf)
        --dns                                 enumerate subdomains of website (subfinder)

    Extended:

        --cache-bypass <value>                try (proxy) cache bypass
        --user-agent <value>                  set 'User-Agent' header
        --max-redirects <num>                 set max redirects (default: 10)
        --timeout <num>                       set max timeout (default: 15)
        --hide-src-ip                         hide source ip from output
```

## Contributing

See **[this](CONTRIBUTING.md)**.

## License

GPLv3 : <http://www.gnu.org/licenses/>

**Free software, Yeah!**
