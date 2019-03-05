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

`htrace.sh` is a shell script for http/https troubleshooting and profiling. It's also a simple wrapper script around several open source security tools.

## How To Use

  > For a more detailed understanding of `htrace.sh`, its parameters, and how it all works, see the **[Wiki](https://github.com/trimstray/htrace.sh/wiki)**.

It's simple:

```bash
# Clone this repository
git clone https://github.com/trimstray/htrace.sh

# Go into the repository
cd htrace.sh

# Install htrace.sh
./setup.sh install

# Install dependencies (Debian/Ubuntu and MacOS support)
#   - I recommend build docker image
#   - before init please see what it does
./dependencies.sh

# Run the app
htrace.sh -u http://nmap.org -s -h
```

> * symlink to `bin/htrace.sh` is placed in `/usr/local/bin`
> * man page is placed in `/usr/local/man/man8`

or use [Dockerfile](https://raw.githubusercontent.com/trimstray/htrace.sh/master/build/Dockerfile):

```bash
# Clone this repository
git clone https://github.com/trimstray/htrace.sh

# Go to build/ directory and build docker image
cd htrace.sh/build && docker build --rm -t htrace.sh -f Dockerfile .

# Run the app
docker run --rm -it --name htrace.sh htrace.sh -u http://nmap.org -s -h
```

## Parameters

Provides the following options:

```bash
    htrace.sh v1.1.1

  Usage:
    htrace.sh <option|long-option>

  Examples:
    htrace.sh -u https://example.com -s -h --testssl --ssllabs
    htrace.sh -u https://example.com -h -M 'POST:name=admin&num=12'
    htrace.sh --url https://example.com --cache-bypass "?${RANDOM}"
    htrace.sh --url https://example.com --ssl --headers --proxy "socks5h://127.0.0.1:9501"

  Options:
        --help                                show this message
        -u|--url <value>                      set url with http/https protocol
        -s|--ssl                              show basic ssl server/connection parameters
        -h|--headers                          show response headers
        -b|--body                             show response body
        -M|--req-method <value>               set request method (default: GET)
        -H|--req-header <value>               set request header(s)
        -p|--proxy <value>                    set proxy server (not for external tools)
        --testssl                             test ssl protocols and ciphers with testssl.sh
        --observatory                         scan domain with mozilla observatory security tool
        --ssllabs                             scan domain with ssllabs security tool
        --mixed-content                       scan website for mixed content
        --nse                                 scan website with nmap nse library
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
