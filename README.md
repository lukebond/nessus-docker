# nessus-docker

A Dockerfile for building a container to run the free version of Nessus, and
a Makefile to assist in the building and running of it.

Designed for use in security workshops that include exercises on Nessus.

Doesn't include the binary, which you must download yourself. The Dockerfile
assumes a particular version of that binary, specifically the 64-bit Debian
package. To download Nessus (requires registration), go here:

https://www.tenable.com/products/nessus-home

To build it:

```
$ make build
```

To run it:

```
$ make run
```
