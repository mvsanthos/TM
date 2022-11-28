# TrendMicro Deep Security Agent for Linux

### Table of Contents

[[_TOC_]]

## Introduction

### Shell Script Linux Trendmicro Deep Security Agent

This script is to install the Trendmicro Deep Security Agent.

Further CDS documentation on Trendmicro Deep Security can be found here: [Malware Protection](https://wiki.siemens.com/x/1xp7DQ)

## Bug and feature request

If something does not work as you expect, please use the [bug report template](https://code.siemens.com/modules/shell-scripts/trendmicro/-/issues/new?issuable_template=bug) to open an issue.

Should you want to raise a feature request, please use the [feature request template](https://code.siemens.com/modules/shell-scripts/trendmicro/-/issues/new?issuable_template=feature_request).

## Dependencies

### Siemens Root Certificates

The Siemens Root Certificates should be installed on the system

- [Siemens Root Certificates - Shell Script](https://code.siemens.com/modules/shell-scripts/siemens-root-ca)

### The following network connection must be allowed:
- virusprotection.it-solutions.atos.net:4455
- virusprotection.it-solutions.atos.net:4456

### The following packages are needed:
- bash
- wget
- curl
- jq
- openssl

Depending on the operating system also:
- gnupg

## How to Use

Please run all any of the following commands as root!

### Install, Activate agent, Check activation

#### Initial Setup

First you have to make sure all files present in this repository are on the server you want to install TrendMicro Deep Security.

Then make sure the shell scripts are executable.

```sh
chmod +x trendmicro
```

### Help

```sh
./trendmicro --help
trendmicro - TrendMicro Deep Security installer for Linux

Usage:
  trendmicro COMMAND
  trendmicro [COMMAND] --help | -h
  trendmicro --version | -v

Commands:
  setup      Setup dependencies for TrendMicro agent
  install    Install TrendMicro agent
  activate   Activates TrendMicro agent
  reset      Reset TrendMicro agent
  check      Check if TrendMicro is activated correctly

Options:
  --help, -h
    Show this help

  --version, -v
    Show version number
```

#### Install required additional certificates

To enable proper signing checks for the agent installer, as well as communication with the backend, you have to install some certificates.  
This can be done through the setup command. For that you need to provide the system you are installing

```sh
trendmicro setup - Setup dependencies for TrendMicro agent

Alias: s

Usage:
  trendmicro setup [OPTIONS]
  trendmicro setup --help | -h

Options:
  --help, -h
    Show this help

  --os-name, -o OS_NAME (required)
    Operating system name
    Allowed: Debian, Ubuntu, SUSE, RedHatEnterprise, Amazon

Examples:
  ./trendmicro setup --os-name Debian
  ./trendmicro setup --os-name SUSE
```
#### Install agent

After the installation of the additional certificates, you can install the agent.

```sh
./trendmicro install --help
trendmicro install - Install TrendMicro agent

Alias: i

Usage:
  trendmicro install [OPTIONS]
  trendmicro install --help | -h

Options:
  --help, -h
    Show this help

  --os-name, -o OS_NAME (required)
    Operating system name
    Allowed: Debian, Ubuntu, SUSE, RedHatEnterprise, Amazon

  --os-version, -v OS_VERSION (required)
    Operating system version

Examples:
  ./trendmicro install --os-name Debian --os-version 10
```

#### Activate agent

Next, you can activate the agent

```sh
./trendmicro activate --help
trendmicro activate - Activates TrendMicro agent

Alias: a

Usage:
  trendmicro activate [OPTIONS]
  trendmicro activate --help | -h

Options:
  --help, -h
    Show this help

  --cloud-provider, -c CLOUD_PROVIDER (required)
    Cloud provider that TrendMicro is being used on
    Allowed: aws, azure, gcp

  --proxy, -p PROXY
    Use a proxy with an agent
    Default: 

Examples:
  ./trendmicro activate --cloud-provider aws
  ./trendmicro activate --cloud-provider aws --proxy de.coia.siemens.net:9400
```

#### Check agent activation

To check the agent activation, you can use the check option.  
It is recommended to wait a couple of minutes between agent activation and checking, as some actions are executed in the background by the agent.

```sh
./trendmicro check --help   
trendmicro check - Check if TrendMicro is activated correctly

Alias: c

Usage:
  trendmicro check
  trendmicro check --help | -h

Options:
  --help, -h
    Show this help

Examples:
  ./trendmicro check
```

#### Reset agent activation

If you want to reset an agent activation, you can do so with the following command.  
This allows you to activate the agent again.

```sh
./trendmicro reset --help
trendmicro reset - Reset TrendMicro agent

Alias: r

Usage:
  trendmicro reset
  trendmicro reset --help | -h

Options:
  --help, -h
    Show this help

Examples:
  ./trendmicro reset
```