<h1 align="left">htrace.sh</h1>

<p align="left">
  <a href="https://travis-ci.org/trimstray/htrace.sh">
    <img src="https://travis-ci.org/trimstray/htrace.sh.svg?branch=master"
        alt="Travis-CI">
  </a>
  <a href="https://www.docker.com/">
    <img src="https://img.shields.io/badge/Docker-Support-blue.svg"
        alt="Docker">
  </a>
</p>

<h4 align="left">Simple shell script to debugging http/https traffic tracing and response headers.</h4>

<p align="center">
    <img src="https://github.com/trimstray/htrace.sh/blob/master/doc/img/htrace.sh_preview.png"
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

It is useful for:

- checking properly web servers/reverse proxies domain configuration
- redirects analysis, eg. to eliminate redirect loops
- checking response headers for each request
- checking basic ssl configuration
- scanning domain with external security tools: **Mozilla Observatory** and **SSL Labs API**

  > Before use **htrace.sh** please see **[Requirements](#requirements)**.

## How To Use

It's simple:

```bash
# Clone this repository
git clone https://github.com/trimstray/htrace.sh

# Go into the repository
cd htrace.sh

# Install
./setup.sh install

# Run the app
htrace.sh --domain https://google.com
```

> * symlink to `bin/htrace.sh` is placed in `/usr/local/bin`
> * man page is placed in `/usr/local/man/man8`

### External tools

**htrace.sh** support external tools for security scans:

- **[Mozilla Observatory](https://github.com/mozilla/http-observatory)** - cli version of [observatory.mozilla.org](observatory.mozilla.org)
- **[Ssllabs](https://github.com/ssllabs/ssllabs-scan)** - command-line reference-implementation client for SSL Labs APIs

### Docker

The configuration is contained in the **Dockerfile**.

#### Build image

```bash
docker build --rm -t htrace.sh -f Dockerfile .
```

#### Run container

```bash
docker run --rm -it --name htrace.sh htrace.sh -d http://nmap.org -h
```

## Requirements

This tool working with:

- **GNU/Linux** (testing on Debian and CentOS)
- **[Bash](https://www.gnu.org/software/bash/)** (testing on 4.4.19)
- **[Curl](https://curl.haxx.se/)** with specific variables support (≥ 7.52.0)
- **[OpenSSL](https://www.openssl.org/)**
- **[Mozilla Observatory](https://github.com/mozilla/http-observatory)**
- **[Ssllabs](https://github.com/ssllabs/ssllabs-scan)**

## Parameters

Provides the following options:

```bash
  Usage:
    htrace.sh <option|long-option>

  Examples:
    htrace.sh --domain https://example.com

  Options:
        --help                                show this message
        -d|--domain <domain_name>             set domain name
        -h|--headers                          show response headers
        -s|--scan <all|observatory|ssllabs>   scan domain with external security tools
```

## Contributing

See **[this](CONTRIBUTING.md)**.

## License

GPLv3 : <http://www.gnu.org/licenses/>

**Free software, Yeah!**
