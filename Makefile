package-install:
	sudo apt-get install w3m
	git clone https://github.com/cask/cask ~/.cask
	PATH="$HOME/.cask/bin:$PATH"
	~/.cask/bin/cask install

lisp-test:
	echo Test start...
	~/.cask/bin/cask exec emacs \
	     -Q -batch \
	     -L . \
	     -l test/create-link-test.el \
	     -f ert-run-tests-batch-and-exit

elisp-lint:
	echo Elisp lint start...
	~/.cask/bin/cask exec emacs \
	-Q -batch \
	-L . \
	-l create-link.el \
	--eval "(require 'elisp-lint)" \
	-f elisp-lint-files-batch --no-indent create-link.el

package-lint:
	echo Package lint start...
	~/.cask/bin/cask exec emacs \
	-Q -batch \
	-L . \
	-l create-link.el \
	--eval "(require 'package-lint)" \
	-f package-lint-batch-and-exit

byte-compile:
	echo Byte compile start...
	~/.cask/bin/cask exec emacs \
	-Q -batch \
	-L . \
	--eval "(setq byte-compile-error-on-warn t)" \
	-f batch-byte-compile *.el
