;; TODO
;; - customizable format
;; - test
;; - some format support
;; - compatible with some packages

;; ex.
;; <a href="https://ja.wikipedia.org/wiki/Emacs">Emacs - Wikipedia</a>

(defgroup create-link nil
  "Generate a well-formed link"
  :group 'convenience
  :prefix "create-link-")

(defcustom create-link-default-format 'html
  "Default format"
  :group 'create-link
  :type '(choice (const :tag "html" html)
                 (const :tag "markdown" markdown)
                 (other :tag "org" org)
                 (other :tag "media-wiki" media-wiki)))

;; format keywords:
;; %url%
;; %title%

(defcustom create-link-format-html
"<a href='%url%'>%title%</a>"
  "html")

(defcustom create-link-format-markdown
  "[%title%](%url%)"
  "markdown")

(defcustom create-link-format-org
  "[[%url%][%title%]]"
  "org")

(defcustom create-link-format-media-wiki
  "[%url% %title%]"
  "media-wiki")

(defun create-link-make-format ()
  (replace-regexp-in-string "%title%"
                            (plist-get eww-data :title)
                            (replace-regexp-in-string "%url%"
                                                      (plist-get eww-data :url)
                                                      create-link-format-markdown)))

(defun create-link-execute (format-type)
    (message "Copied %s" (create-link-make-format))
    (kill-new (create-link-make-format)))

(defun create-link ()
  (interactive)
  (pcase create-link-default-format
    (`html
     (create-link-execute create-link-format-html))
    (`markdown
     (create-link-execute create-link-format-markdown))
    (`org
     (create-link-execute create-link-format-org))
    (`media-wiki
     (create-link-execute create-link-format-media-wiki))
    )
  )
