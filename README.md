<h1 align="center">htrace.sh</h1>

<h4 align="center">Simple shell script to debugging http(s) traffic tracing.</h4>

<p align="center">
  <a href="https://img.shields.io/badge/Branch-master-green.svg">
    <img src="https://img.shields.io/badge/Branch-master-green.svg"
        alt="Branch">
  </a>
  <a href="https://img.shields.io/badge/Version-v1.0.0-lightgrey.svg">
    <img src="https://img.shields.io/badge/Version-v1.0.0-lightgrey.svg"
        alt="Version">
  </a>
  <a href="https://travis-ci.org/trimstray/htrace.sh">
    <img src="https://travis-ci.org/trimstray/htrace.sh.svg?branch=master"
        alt="Travis-CI">
  <a href="http://www.gnu.org/licenses/">
    <img src="https://img.shields.io/badge/license-GNU-blue.svg"
        alt="License">
  </a>
</p>

<p align="center">
   <a href="#description">Description</a>
 • <a href="#how-to-use">How To Use</a>
 • <a href="#parameters">Parameters</a>
 • <a href="#requirements">Requirements</a>
 • <a href="#other">Other</a>
 • <a href="#license">License</a>
 • <a href="https://github.com/trimstray/htrace.sh/wiki">Wiki</a>
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

Simple shell script to debugging http(s) traffic tracing. It is useful for redirects analysis, eg. to eliminate redirect loops.

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

## Parameters

Provides the following options:

```bash
  Usage:
    htrace.sh <option|long-option>

  Examples:
    htrace.sh --domain https://google.com

  Options:
        --help                        show this message
        --domain <domain_name>        set domain name
```

## Requirements

**<u>htrace.sh</u>** uses external utilities to be installed before running:

- [curl](https://curl.haxx.se/)

This tool working with:

- **GNU/Linux** (testing on Debian and CentOS)
- **Bash** (testing on 4.4.19)

Also you will need **root access**.

## Other

### Contributing

See **[this](CONTRIBUTING.md)**.

### Project architecture

See **<a href="https://github.com/trimstray/htrace.sh/wiki/Project-architecture">this</a>**.

## License

GPLv3 : <http://www.gnu.org/licenses/>

**Free software, Yeah!**
