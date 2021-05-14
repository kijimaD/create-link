;; Tests for create-link

(require 'ert)
(require 'create-link)

(ert-deftest create-link-replace-dictionary-w3m-test ()
  (w3m-goto-url "google.com")
  (should (equal (create-link-replace-dictionary)
                 '(("%url%" . "https://www.google.com/")
                   ("%title%" . "Google")))))

(ert-deftest create-link-replace-dictionary-eww-test ()
  (eww-open-in-new-buffer)
  (eww-reload)
  (should (equal (create-link-replace-dictionary)
                 '(("%url%" . "http://google.com/")
                   ("%title%" . "")))))
;; Can't get title at the test.

(ert-deftest create-link-replace-dictionary-file-test ()
  (let ((buffer "buffer")
        (file "file"))
    (switch-to-buffer buffer)
    (should (equal
             buffer
             (cdr (assoc "%title%" (create-link-replace-dictionary)))))

    (write-file file)
    (should (string-match-p
             (format ".*/" file)
             (cdr (assoc "%url%" (create-link-replace-dictionary)))))
    (delete-file file)))

(provide 'create-link-test)\n ;;; create-link-test.el ends here
