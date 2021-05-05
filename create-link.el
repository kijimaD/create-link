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

;; url → text
(defcustom create-link-format-html
  "<a href='%s'>%s</a>"
  "html")

;; 順番が違うのでフォーマット文字列で指定できるようにする必要がある。どうしたらよいのだろう。
;; text → url
(defcustom create-link-format-markdown
  "[%s](%s)"
  "markdown")

(defcustom create-link-format-org
  "[[%s][%s]]"
  "org")

(defcustom create-link-format-media-wiki
  "[%s %s]"
  "media-wiki")

(defun create-link-execute (format-type url title)
  (message "Copied %s" (format format-type url title))
  (kill-new (format format-type url title)))

;; formatが順番に依存してる
(defun create-link ()
  (interactive)
  (let ((url (plist-get eww-data :url))
        (title (plist-get eww-data :title)))
    (pcase create-link-default-format
      (`html
       (create-link-execute create-link-format-html url title))
      (`markdown
       (create-link-execute create-link-format-markdown title link)) ; 逆
      (`org
       (create-link-execute create-link-format-org url title))
      (`media-wiki
       (create-link-execute create-link-format-media-wiki url title))
      ))
  )

;; (defun title-link-w3m ()
;;   (interactive)
;; )
