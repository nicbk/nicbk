---
title: "Hashing Functions"
date: 2020-06-25
draft: false
---

I recently read [The Rust Programming
Language](https://doc.rust-lang.org/stable/book/).
The whole language feels very cohesive. It has an official package repository
located at [crates.io](https://crates.io).
Although I am not a fan of centralized packaging solutions, the clear benefit
of this system is its ease of use.
Libraries can be added to a project by simply adding the name of that library
to the project configuration file.

I thought that a great first project would be to implement the [Secure Hash
Standard (NIST FIPS 180-4)](https://doi.org/10.6028/NIST.FIPS.180-4), which
includes the SHA-1 and SHA-2 (SHA-256, SHA-512, ...).
Yesterday I implemented SHA-1, and its repository is located
[here](https://github.com/nicbk/sha-one).
I have not optimized it.
This is quite obvious as hashing GNU Make, which is about a megabyte large, took
multiple seconds.
However, before I return to SHA-1, I might as well implement SHA-256 and
SHA-512.
