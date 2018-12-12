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
    <img src="https://github.com/trimstray/htrace.sh/blob/master/doc/img/htrace.sh_preview.png"
        alt="Master">
</p>

<p align="center">
    <img src="https://raw.githubusercontent.com/trimstray/htrace.sh/master/doc/img/htrace.sh_preview-01.png" width="32%"></img>
    <img src="https://raw.githubusercontent.com/trimstray/htrace.sh/master/doc/img/htrace.sh_preview-02.png" width="32%"></img>
    <img src="https://raw.githubusercontent.com/trimstray/htrace.sh/master/doc/img/htrace.sh_preview-03.png" width="32%"></img>
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

In my daily work, I missed a tool with which I could test the configuration of domains in a simple way. The ability to use *curl* or *openssl* is very important, but I did not have the tools to automate this process. Until now, I used the tools available on the web, but each of them had some shortcomings.

`htrace.sh` is a shell script that allows you to validate your domain configuration and catch any errors (e.g. redirect loops). It also displays basic information about the ssl configuration (if available), response headers, extended ssl configuration using testssl.sh tool, checks for mixed content and performs security scans using Nmap scripts and great external tools such as Ssllabs or Mozilla Observatory.

## Functions

It is useful for:

- checking **properly domain configuration** (web servers/reverse proxies)
- displaying basic **HTTP information** including **URLs, GeoIP, status codes** and **protocol info**
- checking **HTTP request latency** (`time_connect` and `time_total`)
- **redirects analysis** (and follows it), e.g. to eliminate redirect loops
- viewing and analyzing **response headers** for each request
  - try **bypassing cache**
- checking **basic ssl** configuration
  - **validation** of the certificates (e.g. `date`, `cn`, `san`), check **sni** and **verification** ssl connection
- checking **extended ssl** configuration with **testssl.sh**
- scanning domain for **Mixed Content**
- scanning domain using **Nmap NSE Library** (34 scripts)
- scanning domain with external security tools: **Mozilla Observatory** and **SSL Labs API**

  > Before use `htrace.sh` please see **[Requirements](#requirements)**.

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
htrace.sh -d http://nmap.org -s -h
```

> * symlink to `bin/htrace.sh` is placed in `/usr/local/bin`
> * man page is placed in `/usr/local/man/man8`

## External tools

`htrace.sh` support external tools for security scans:

- **testssl.sh** - cli tool for testing SSL configuration, working with `https`  
  include params: `--quiet --protocols --cipher-per-proto --server-preference --server-defaults \"$_host\"`
- **Mozilla Observatory** - cli version of [observatory.mozilla.org](https://observatory.mozilla.org/), working with `http` and `https`  
  include params: `--format=report --rescan --zero --quiet`
- **Ssllabs** - command-line reference-implementation client for [SSL Labs API](https://www.ssllabs.com/ssltest/), working with `https`  
  include params: `-quiet -grade`
- **mixed-content-scan** - cli tool for check HTTPS-enabled website for Mixed Content, working with `https`  
  include params: `-user-agent \"$_user_agent\" --no-check-certificate`
- **Nmap NSE Library** - provide automated security scans with Nmap, working with `http` and `https`  
  include scripts:
  * dns-brute
  * http-auth-finder
  * http-chrono
  * http-cookie-flags
  * http-cors
  * http-cross-domain-policy
  * http-csrf
  * http-dombased-xss
  * http-enum
  * http-errors
  * http-git
  * http-grep
  * http-internal-ip-disclosure
  * http-jsonp-detection
  * http-malware-host
  * http-methods
  * http-passwd
  * http-phpself-xss
  * http-php-version
  * http-robots.txt
  * http-sitemap-generator
  * http-shellshock
  * http-stored-xss
  * http-title
  * http-unsafe-output-escaping
  * http-useragent-tester
  * http-vhosts
  * http-waf-detect
  * http-waf-fingerprint
  * http-xssed
  * traceroute-geolocation.nse
  * ssl-enum-ciphers
  * whois-domain
  * whois-ip

When scanning for **mixed content** and with **Nmap scripting engine**, remember that it may take a long time before the entire site is checked. In addition, NSE scripts can generate a large number of requests.

## Reports

If you want to generate a report in html format, use the **[ansi2html.sh](https://raw.githubusercontent.com/pixelb/scripts/master/scripts/ansi2html.sh)** tool. A detailed description of use:

```bash
htrace.sh -d https://nmap.org -s -h | ansi2html --bg=dark > report.html
```

## Docker

The configuration is in the **build/Dockerfile**.

### Build image

```bash
cd htrace.sh/build
docker build --rm -t htrace.sh -f Dockerfile .
```

### Run container

```bash
docker run --rm -it --name htrace.sh htrace.sh -d http://nmap.org -s -h
```

## Requirements

This tool working with:

- **GNU/Linux** (testing on Debian and CentOS)
- **[Bash](https://www.gnu.org/software/bash/)** (testing on 4.4.19)
- **[Curl](https://curl.haxx.se/)** with specific variables support (≥ 7.52.0)
- **[OpenSSL](https://www.openssl.org/)** (testing on 1.1.0g/h)
- **[Mozilla Observatory](https://github.com/mozilla/http-observatory)** (testing on 0.7.1)
- **[Ssllabs](https://github.com/ssllabs/ssllabs-scan)** (testing on v1.5.0)
- **[mixed-content-scan](https://github.com/bramus/mixed-content-scan)** with **php-curl**
- **[testssl.sh](https://testssl.sh/)** (testing on 3.0rc3)
- **[Nmap](https://nmap.org/)** (testing on 7.70)

If you don't know how to install these tools and where they should be placed, please see in **[Dockerfile](https://github.com/trimstray/htrace.sh/blob/master/build/Dockerfile)** where exactly every step is described.

## Parameters

Provides the following options:

```bash
    htrace.sh v1.0.9

Usage:
    htrace.sh <option|long-option>

  Examples:
    htrace.sh --domain https://example.com
    htrace.sh --domain https://example.com --cache-bypass "?${RANDOM}"
    htrace.sh --domain https://example.com --ssl --headers --testssl --ssllabs

  Options:
        --help                                show this message
        -d|--domain <domain_name>             set domain name
        -s|--ssl                              show basic ssl server/connection params
        -h|--headers                          show response headers
        --testssl                             test ssl protocols and ciphers with testssl.sh
        --observatory                         scan domain with mozilla observatory security tool
        --ssllabs                             scan domain with ssllabs security tool
        --mixed-content                       scan website for mixed content
        --nse                                 scan website with nmap nse library
        --cache-bypass <val>                  try (proxy) cache bypass
        --user-agent <val>                    set 'User-Agent' header
        --max-redirects <num>                 set max redirects (default: 10)
        --timeout <num>                       set max timeout (default: 15)
```

## Issues

#### `not found in PATH`

If you getting this error:

```
not found in PATH: <...>
```

You should look here: **[#18](https://github.com/trimstray/htrace.sh/issues/18)**.

#### `unable to get local issuer certificate`

Set correct environment variable:

```
export SSL_CERT_DIR=/path/to/ca/dir
```

## Contributing

See **[this](CONTRIBUTING.md)**.

## License

GPLv3 : <http://www.gnu.org/licenses/>

**Free software, Yeah!**
