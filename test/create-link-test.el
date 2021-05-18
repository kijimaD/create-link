;;; create-link-test.el --- Tests for create-link

(require 'create-link)
(require 'ert)
(require 'eww)
(require 'w3m)
(require 'cl-lib)

;;; Code:

;; Useful debug information
(message "Running tests on Emacs %s" emacs-version)

(ert-deftest create-link-make-format-eww-test ()
  "Eww buffer."
  ;; eww
  (eww "google.com")
  (sit-for 2)
  (should (string-match-p
           (format "<a href='.*google.com.*'>.*Google.*</a>")
           (create-link-make-format))))

(ert-deftest create-link-make-format-w3m-test ()
  "W3m buffer."
  (w3m-goto-url "google.com")
  (sit-for 2)
  (should (string-match-p
           (format "<a href='.*google.com.*'>.*Google.*</a>")
           (create-link-make-format))))

(ert-deftest create-link-make-format-file-test ()
  "File buffer."
  (let ((buffer "buffer")
        (file "file"))
    (find-file file)
    (rename-buffer buffer)

    (should (string-match-p
             (format "<a href='.*/%s'>%s</a>" file buffer)
             (create-link-make-format)))
    (delete-file file)
    (kill-buffer)))

(ert-deftest create-link-make-format-manual-test ()
  "Manual format selection."
  (let ((buffer "buffer")
        (file "file"))
    (find-file file)
    (rename-buffer buffer)

    (should (string-match-p
             (format "\[\[.*/%s\]\[%s\]\]" file buffer)
             (create-link-make-format create-link-format-org)))
    (delete-file file)
    (kill-buffer)))

(ert-deftest create-link-make-format-region-test ()
  "If use region, fill title with region."
  (let ((file "file")
        (content "content"))
    (find-file file)
    (erase-buffer)
    (insert content)
    (goto-char (point-min))
    (mark-word)

    (should (string-match-p
             (format "<a href='.*/%s'>%s</a>" file content)
             (create-link-make-format)))
    (delete-file file)
    (kill-buffer)))

(ert-deftest create-link-make-format-url-test ()
  "If point on url, fill title with scraped title."
  (let ((file "file")
        (content "http://google.com"))
    (find-file file)
    (erase-buffer)
    (insert content)
    (goto-char (point-min))

    (should (string-match-p
             (format "<a href='%s'>.*Google.*</a>" content)
             (create-link-make-format)))
    (delete-file file)
    (kill-buffer)))

(ert-deftest create-link-make-format-filter-test ()
  "If set filter custom, it filter title."
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
     '(create-link-filter-title-replace ""))
    (delete-file file)
    (kill-buffer)))

(provide 'create-link-test)

;;; create-link-test.el ends here
