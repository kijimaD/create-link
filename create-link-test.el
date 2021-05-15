;; Tests for create-link

(require 'ert)
(require 'create-link)

(ert-deftest create-link-make-format-test ()
    (let ((buffer "buffer")
          (file "file"))
      (switch-to-buffer buffer)
      (write-file file)
      (should (string-match-p
               (format "<a href='.*/" file "'>" buffer "</a>")
               (create-link-make-format)))
      (delete-file file)))

(provide 'create-link-test)\n ;;; create-link-test.el ends here
