;;; create-link-test.el --- Tests for create-link

(require 'ert)
(require 'eww)
(require 'w3m)
(require 'create-link)

;;; Code:

;; Useful debug information
(message "Running tests on Emacs %s" emacs-version)

(ert-deftest create-link-make-format-eww-test ()
  "Each buffer can make format."
  ;; eww
  (eww "google.com")
  (sit-for 2)
  (should (string-match-p
           (format "<a href='.*google.com.*'>.*Google.*</a>")
           (create-link-make-format))))

(ert-deftest create-link-make-format-w3m-test ()
  ;; w3m
  (w3m-goto-url "google.com")
  (sit-for 2)
  (should (string-match-p
           (format "<a href='.*google.com.*'>.*Google.*</a>")
           (create-link-make-format))))

(ert-deftest create-link-make-format-file-test ()
  ;; file
  (let ((buffer "buffer")
        (file "file"))
    (find-file file)
    (should (string-match-p
             (format "<a href='.*/" file "'>" buffer "</a>")
             (create-link-make-format)))))

(ert-deftest create-link-make-format-context-test ()
  "Each context can make format."
  (let ((file "file")
        (content "content"))
    (find-file file)
    (insert content)
    (goto-char (point-min))
    (mark-word)

    (should (string-match-p
             (format "<a href='.*/" file "'>" content "</a>")
             (create-link-make-format)))
    (delete-file file)))

(ert-deftest create-link-make-format-filter-test ()
  (let ((file "file")
        (buffer "buffer"))
    (custom-set-variables
     '(create-link-filter-title-regexp ".er")
     '(create-link-filter-title-replace ""))
    (find-file file)
    (rename-buffer buffer)

    (should (string-match-p
             (format "<a href='.*/file'>buf</a>") ; 'buffer' -> 'buf'
             (create-link-make-format)))
    (custom-set-variables
     '(create-link-filter-title-regexp "<.*>")
     '(create-link-filter-title-replace ""))))

(provide 'create-link-test)

;;; create-link-test.el ends here
