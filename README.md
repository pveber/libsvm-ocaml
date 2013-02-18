LIBSVM-OCaml - LIBSVM Bindings for OCaml
========================================

LIBSVM-OCaml is an [OCaml](http://www.ocaml.org) library with bindings to the
[LIBSVM](http://www.csie.ntu.edu.tw/~cjlin/libsvm/) library.

Installation
------------

To build and install libsvm-ocaml:

    $ make
    $ make install

### Tests _(optionnal)_

To build and execute tests:

    $ ./configure --enable-tests
    $ make test

### Documentation _(optional)_

To build the documentation:

    $ make doc

It will then be installed by `make install`.

Credits
-------

  * Dominik Brugger wrote the initial release for LIBSVM 2.8.
