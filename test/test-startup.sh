git clone https://github.com/cask/cask ~/.cask
PATH="$HOME/.cask/bin:$PATH"

cask install

cask exec emacs \
     -Q -batch \
     -L . \
     -l test/create-link-test.el \
     -f ert-run-tests-batch-and-exit

cask exec emacs \
     -Q -batch \
     -L . \
     -l create-link.el \
     --eval "(require 'package-lint)" \
     -f package-lint-batch-and-exit
