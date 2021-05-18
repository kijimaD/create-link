package-install:
	sudo apt-get install w3m
	git clone https://github.com/cask/cask ~/.cask
	PATH="$HOME/.cask/bin:$PATH"
	cask install

lisp-test:
	echo Test start...
	cask exec emacs \
	     -Q -batch \
	     -L . \
	     -l test/create-link-test.el \
	     -f ert-run-tests-batch-and-exit

package-lint:
	echo Package lint start...
	cask exec emacs \
	-Q -batch \
	-L . \
	-l create-link.el \
	--eval "(require 'package-lint)" \
	-f package-lint-batch-and-exit

byte-compile:
	echo Byte compile start...
	cask exec emacs \
	-Q -batch \
	-L . \
	--eval "(setq byte-compile-error-on-warn t)" \
	-f batch-byte-compile *.el
