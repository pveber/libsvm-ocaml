LIBSVM-OCaml - LIBSVM Bindings for OCaml
========================================

LIBSVM-OCaml is an [OCaml](http://www.ocaml.org) library with bindings to the
[LIBSVM](http://www.csie.ntu.edu.tw/~cjlin/libsvm/) library.

Installation
------------

The easiest way to install the LIBSVM development files is by using APT:

    $ apt-get install libsvm-dev

If you want to build and install LIBSVM from source, download the package
[here](http://www.csie.ntu.edu.tw/~cjlin/libsvm/#download) and type in the
package directory:

    $ make lib
    $ mkdir /usr/include/libsvm
    $ cp svm.h /usr/include/libsvm
    $ cp libsvm.so.2 /usr/lib
    $ ln -s /usr/lib/libsvm.so.2 /usr/lib/libsvm.so

To build and install libsvm-ocaml:

    $ make
    $ make install

### Tests _(optional)_

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
