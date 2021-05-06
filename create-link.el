;; TODO
;; [x] - customizable format
;; - some format support
;; - test
;; - compatible with some packages(eww, w3m, magit-forge)
;; - without a argument
;; - scrape title

;; ex.
;; <a href="https://ja.wikipedia.org/wiki/Emacs">Emacs - Wikipedia</a>

(defgroup create-link nil
  "Generate a formatted current page link."
  :group 'convenience
  :prefix "create-link-")

(defcustom create-link-default-format 'html
  "Default link format."
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

(defun create-link-raw-format ()
  (pcase create-link-default-format
    (`html
     create-link-format-html)
    (`markdown
     create-link-format-markdown)
    (`org
     create-link-format-org)
    (`media-wiki
     create-link-format-media-wiki)
    ))

(defun create-link-make-format (title url)
  (replace-regexp-in-string
   "%title%"
   title
   (replace-regexp-in-string
    "%url%" url (create-link-raw-format))))

(defun create-link-browser ()
  (cond ((string-match-p "w3m" (buffer-name))
         (create-link-make-format w3m-current-title w3m-current-url))
        ((string-match-p "eww" (buffer-name))
         (create-link-make-format (plist-get eww-data :title) (plist-get eww-data :url)))
        (t (message "Can't create link!"))))

(defun create-link ()
  (interactive)
    (message "Copied! %s" (create-link-browser))
    (kill-new (create-link-browser)))
