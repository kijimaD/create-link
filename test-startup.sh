git clone https://github.com/cask/cask ~/.cask
PATH="$HOME/.cask/bin:$PATH"

cask install
cask exec emacs -Q -batch -L . -l create-link-test.el -f ert-run-tests-batch-and-exit
