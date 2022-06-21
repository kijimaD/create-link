;;; create-link-test.el --- Tests for create-link

(require 'create-link)
(require 'ert)
(require 'eww)
(require 'cl-lib)

;;; Code:

;; Useful debug information
(message "Running tests on Emacs %s" emacs-version)

(ert-deftest create-link-make-format-eww-test ()
  "Eww buffer."
  ;; eww
  (eww "example.com")
  (sit-for 1)
  (should (string-match-p
           (format "<a href='.*example.com.*'>Example Domain</a>")
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

(ert-deftest create-link-make-format-manual ()
  "Manual format selection.
<a href='http://example.com/'>Example Domain</a> - html
[Example Domain](http://example.com/) - markdown
[[http://example.com/][Example Domain]] - org
[http://example.com/ Example Domain] - doku-wiki
\href{http://example.com/}{Example Domain} - latex"
  (eww "example.com")
  (sit-for 1)
  (should (string-match-p
           (format "<a href='.*example.com.*'>Example Domain</a>")
           (create-link-make-format 'create-link-format-html)))
  (should (string-match-p
           (format "\\[Example Domain\\]\(http://example.com/\)")
           (create-link-make-format 'create-link-format-markdown)))
  (should (string-match-p
           (format "\\[\\[http://example.com/\\]\\[Example Domain\\]\\]")
           (create-link-make-format 'create-link-format-org)))
  (should (string-match-p
           (format "[[http://example.com/|Example Domain]]")
           (create-link-make-format 'create-link-format-doku-wiki)))
  (should (string-match-p
           (format "\\[http://example.com/ Example Domain\\]")
           (create-link-make-format 'create-link-format-media-wiki)))
  (should (string-match-p
           (format "[http://example.com/ Example Domain]")
           (create-link-make-format 'create-link-format-latex))))

(ert-deftest create-link-make-format-region-test ()
  "If use region, fill title with region."
  (let ((file "file")
        (content "content"))
    (find-file file)
    (erase-buffer)
    (insert content)
    (goto-char (point-min))
    (transient-mark-mode)
    ;; (region-active-p) -> Return t if Transient Mark mode is enabled and the mark is active.
    (mark-word)

    (should (string-match-p
             (format "<a href='.*/%s'>%s</a>" file content)
             (create-link-make-format)))
    (delete-file file)
    (kill-buffer)))

(ert-deftest create-link-make-format-url-test ()
  "If point on url, fill title with scraped title."
  (let ((file "file")
        (content "http://example.com"))
    (find-file file)
    (erase-buffer)
    (insert content)
    (goto-char (point-min))

    (should (string-match-p
             (format "<a href='%s'>Example Domain</a>" content)
             (create-link-make-format)))
    (delete-file file)
    (kill-buffer)))

(ert-deftest create-link-make-format-rule-test ()
  "Apply specific format rule."
  (let ((file "file")
        (buffer "buffer"))
    (find-file file)
    (rename-buffer buffer)

    (should (string-match-p
             (format "\\href{run:.*%s}{%s}" file buffer)
             (create-link-make-format 'create-link-format-latex)))
    (delete-file file)
    (kill-buffer)))

(provide 'create-link-test)

;;; create-link-test.el ends here
