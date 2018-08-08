<h1 align="left">htrace.sh</h1>

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

<div align="center">
  <sub>Created by
  <a href="https://twitter.com/trimstray">trimstray</a> and
  <a href="https://github.com/trimstray/htrace.sh/graphs/contributors">
    contributors
  </a>
</div>

<br>

## Description

In my daily work, I missed a tool with which I could test the configuration of domains in a simple way. The ability to use *curl* or *openssl* is very important, but I did not have the tools to automate this process. Until now, I used the tools available on the web, but each of them had some shortcomings. **Htrace.sh** is a shell script that allows you to validate your domain configuration and catch any errors (eg. redirect loops). It also displays basic information about the ssl configuration (if available), response headers, checks for mixed content and performs security scans using Nmap scripts and great external tools such as Ssllabs or Mozilla Observatory.

It is useful for:

- checking **properly domain configuration** (web servers/reverse proxies)
- **redirects analysis**, eg. to eliminate redirect loops
- checking **response headers** for each request
- checking **basic ssl** configuration
  - **validation** of the certificates (date, cn, san) and **verification** ssl connection
- scanning domain for **Mixed Content**
- scanning domain using **Nmap NSE Library**
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

## External tools

**htrace.sh** support external tools for security scans:

- **Mozilla Observatory** - cli version of [observatory.mozilla.org](https://observatory.mozilla.org/)  
  with params: `--format=report --rescan --zero --quiet`
- **Ssllabs** - command-line reference-implementation client for [SSL Labs API](https://www.ssllabs.com/ssltest/)  
  with params: `-quiet -grade`
- **mixed-content-scan** - cli tool for check HTTPS-enabled website for Mixed Content  
  with params: `-user-agent \"$_user_agent\"--no-check-certificate`
- **Nmap NSE Library** - provide automated security scans with Nmap  
  with scripts:
  * http-auth-finder
  * http-chrono
  * http-cookie-flags
  * http-cors
  * http-cross-domain-policy
  * http-csrf
  * http-dombased-xss
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
  * http-unsafe-output-escaping
  * http-useragent-tester
  * http-vhosts
  * http-xssed
  * ssl-enum-ciphers
  * whois-ip

  > When scanning for **mixed content** and **nmap scripting engine**, remember that it may take a long time before the entire site is checked.

## Reports

If you want to generate a report in html format, use the **[ansi2html.sh](https://raw.githubusercontent.com/pixelb/scripts/master/scripts/ansi2html.sh)** tool. A detailed description of use:

```bash
htrace.sh -d https://nmap.org -s -h | ansi2html --bg=dark > report.html
```

## Docker

The configuration is contained in the **build/Dockerfile**.

### Build image

```bash
cd htrace.sh/build
docker build --rm -t htrace.sh -f Dockerfile .
```

### Run container

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
- **[mixed-content-scan](https://github.com/bramus/mixed-content-scan)**
- **[Nmap](https://nmap.org/)**

## Parameters

Provides the following options:

```bash
  Usage:
    htrace.sh <option|long-option>

  Examples:
    htrace.sh --domain https://example.com
    htrace.sh --domain https://example.com -s -h --scan ssllabs

  Usage:
    htrace.sh <option|long-option>

  Examples:
    htrace.sh --domain https://example.com
    htrace.sh --domain https://example.com -s -h --scan ssllabs

  Options:
        --help                                show this message
        -d|--domain <domain_name>             set domain name
        -s|--ssl                              show ssl server/connection params
        -h|--headers                          show response headers
        --scan <all|observatory|ssllabs>      scan domain with external security tools
        --mixed-content                       scan website for mixed content
        --nse                                 scan website with nmap nse library
        --user-agent <val>                    set 'User-Agent' header
        --max-redirects <num>                 set max redirects (default: 10)
        --timeout <num>                       set max timeout (default: 15)
```

## Contributing

See **[this](CONTRIBUTING.md)**.

## License

GPLv3 : <http://www.gnu.org/licenses/>

**Free software, Yeah!**
