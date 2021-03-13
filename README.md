# limbic.fi

## Technologies

- [Common Lisp HyperSpec](http://www.lispworks.com/documentation/HyperSpec/Front/)
- [SBCL - Steel Bank Common Lisp](http://www.sbcl.org/)
- [SLIME - The Superior Lisp Interaction Mode for Emacs](https://common-lisp.net/project/slime/)
- [Github slime/slime](https://github.com/slime/slime)
- [CLOG - Common Lisp Onmificent GUI](https://github.com/rabbibotton/clog)
- [The CLOG Manual](https://rabbibotton.github.io/clog/clog-manual.html)

## Setup

In your shell:

```
$ mkdir common-lisp
$ cd ~/common-lisp
$ git clone https://github.com/rabbibotton/clog.git
```

In your Emacs:

Make sure you have MELPA setup, then:

```
M-x package-install RET slime RET
```

In your Emacs config somewhere:

```
(setq inferior-lisp-program "sbcl")
```

And then run SLIME:

```
M-x slime
```

## OpenSSL

If you see this:

```
Unable to load any of the alternatives:
   ("libcrypto-1_1-x64.dll" "libeay32.dll")
   [Condition of type CFFI:LOAD-FOREIGN-LIBRARY-ERROR]
```

Then you are missing OpenSSL.

- https://www.openssl.org/
- https://github.com/openssl/openssl
- https://wiki.openssl.org/index.php/Binaries
- https://slproweb.com/products/Win32OpenSSL.html

## SQLite

If you see this:

```
Unable to load any of the alternatives:
   ((:DEFAULT "libsqlite3") (:DEFAULT "sqlite3"))
   [Condition of type CFFI:LOAD-FOREIGN-LIBRARY-ERROR]

```

Then you are missing SQLite.

- https://sqlite.org/index.html
- https://sqlite.org/download.html
- Get the download with the DLL.
- Extract it somewhere, I used `C:\Windows\System32\`, but other places will work.
- Add that to your path so the DLL can be found.

## License

Copyright © 2021 Christopher Mark Gore, all rights reserved.
