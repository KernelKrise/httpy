# httpy

A simple Python HTTP download server with cache-disabled headers. Useful for quickly transferring files during CTF challenges or pentesting.

For educational and authorized security testing purposes only.

## Installation

With `curl`:
```shell
curl -fsSL https://raw.githubusercontent.com/KernelKrise/httpy/refs/heads/main/install.sh | bash
```

With `wget`:
```shell
wget -qO- https://raw.githubusercontent.com/KernelKrise/httpy/refs/heads/main/install.sh | bash
```

## Usage

```
Usage: httpy [-h] [-b BIND] [-p PORT]

Simple HTTP download server.

options:
  -h, --help       show this help message and exit
  -b, --bind BIND  Address to bind the server (default: 0.0.0.0)
  -p, --port PORT  Port to listen on (default: 9000)
```

## Examples

```
$ ./httpy -b 127.0.0.1 -p 9000   
[*] Starting HTTP server on 127.0.0.1:9000
127.0.0.1 - - [24/Jan/2026 01:29:10] "GET /example HTTP/1.1" 200 -
^C
[*] Shutting down HTTP server...
```
