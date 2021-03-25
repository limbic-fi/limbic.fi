# limbic.fi

## Technologies

- [Common Lisp HyperSpec](http://www.lispworks.com/documentation/HyperSpec/Front/)
- [SBCL - Steel Bank Common Lisp](http://www.sbcl.org/)
- [ASDF](https://common-lisp.net/project/asdf/)
- [ASDF Manual](https://www.common-lisp.net/project/asdf/asdf.html)
- [Quicklisp](https://www.quicklisp.org/beta/)
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

```lisp
(setq inferior-lisp-program "sbcl")
```

And then run SLIME:

```
M-x slime
```

### SBCL

You can configure how SBCL works at startup with the file `~/.sbclrc`.
If you don't find the file there, check what SBCL tells you with:

```lisp
(SB-IMPL::USERINIT-PATHNAME)
```

The main bit you'll probably want to add there is some paths for ASDF:

#### My Windows Setup:

```lisp
(setf asdf:*central-registry*
      (list* '*default-pathname-defaults*
             #p"C:/Programming/Lisp/"
             #p"C:/Programming/limbic.fi/"
             asdf:*central-registry*))
```

#### My Linux Setup:

```lisp
(setf asdf:*central-registry*
      (list* '*default-pathname-defaults*
             #p"~/programming/lisp/systems/"
             asdf:*central-registry*))
```

And I just add symlinks for each ASDF file I care about in the `~/programming/lisp/systems` directory.
Alternatively, you could add lots of paths there instead.

### OpenSSL

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

### SQLite

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

## VirtualBox

Settings > Network > Adapter 1 > Advanced > Port Forwarding

Forward host port 8080
to guest port 8080

So that then you can browse in your host machine.

## Running Locally

Run SLIME in Emacs:

```
M-x slime
```

In the SLIME REPL:

```
(asdf:operate 'asdf:load-op ':limbic/browser)
(in-package :limbic/browser)
(main)
```

You then should be able to connect to the webpage frontend via 
http://127.0.0.1:8080/

## License

Copyright © 2021 Christopher Mark Gore, all rights reserved.
