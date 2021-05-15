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
    (switch-to-buffer buffer)
    (write-file file)
    (should (string-match-p
             (format "<a href='.*/" file "'>" buffer "</a>")
             (create-link-make-format)))
    (delete-file file)))

(ert-deftest create-link-make-format-context-test ()
  "Each context can make format."
  (let ((file "file")
        (content "content"))
    (switch-to-buffer file)
    (insert content)
    (goto-char (point-min))
    (mark-word)
    (write-file file)

    (should (string-match-p
             (format "<a href='.*/" file "'>" content "</a>")
             (create-link-make-format)))
    (delete-file file)))

(ert-deftest create-link-make-format-filter-test ()
  (custom-set-variables
   '(create-link-filter-title-regexp "l."))
  (find-file "fixture")
  (rename-buffer "title")
  (mark-word)
  (should (string-match-p
           (format "<a href='.*/fixture'>tit</a>") ; 'title' -> 'tit'
           (create-link-make-format)))
  (custom-set-variables
   '(create-link-filter-title-regexp "<.*>")))

(provide 'create-link-test)

;;; create-link-test.el ends here
