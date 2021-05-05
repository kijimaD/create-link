;; TODO
;; - customizable format
;; - test
;; - some format support
;; - compatible with some packages

;; ex.
;; <a href="https://ja.wikipedia.org/wiki/Emacs">Emacs - Wikipedia</a>

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

;; get url+title test
(defun create-link-get-eww ()
  (interactive)
  (let ((url (plist-get eww-data :url))
        (title (plist-get eww-data :title)))
    (create-link-copy url title)))

(defun create-link-copy (url title)
  (interactive)
  (message "Copied %s" (format create-link-format-html url title))
  (kill-new (format create-link-format-html url title)))

;; (defun create-link-format (url title)
;;   (format "[%s](%s)" title url))

;; (defun title-link-w3m ()
;;   (interactive)
;; )

;; URL取得
;; format
