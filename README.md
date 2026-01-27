# httpy

A simple Python HTTP download/upload server with no caching. Useful for quickly transferring files during CTF challenges or pentesting.

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

With `iwr` (Windows/PowerShell):

```shell
iwr https://raw.githubusercontent.com/KernelKrise/httpy/refs/heads/main/install.ps1 | iex
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

Start server:

```shell
httpy -b 127.0.0.1 -p 9000
```

Download file (curl):

```shell
curl -fsSL http://127.0.0.1:9000/README.md > EXAMPLE.md
```

Download file (wget):

```shell
wget -qO- http://127.0.0.1:9000/README.md > EXAMPLE.md
```

Download file (Invoke-WebRequest):

```shell
iwr http://127.0.0.1:9000/README.md -OutFile EXAMPLE.md
```

Upload file (curl):

```shell
curl --data-binary @README.md http://127.0.0.1:9000/EXAMPLE.md
```

Upload file (wget):

```shell
wget --post-file=README.md http://127.0.0.1:9000/EXAMPLE.md
```

Upload file (Invoke-WebRequest):

```shell
iwr -Uri http://127.0.0.1:9000/EXAMPLE.md -Method POST -InFile README.md
```
