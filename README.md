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

## License

Copyright © 2021 Christopher Mark Gore, all rights reserved.
