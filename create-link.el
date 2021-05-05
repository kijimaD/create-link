;; TODO
;; - customizable format
;; - test
;; - some format support
;; - compatible with some packages

;; ex.
;; <a href="https://ja.wikipedia.org/wiki/Emacs">Emacs - Wikipedia</a>

;; (defcustom format-type :markdown)
;; (defcustom format-html)
;; (defcustom format-markdown)
;; (defcustom format-org)

;; get url+title test
(defun title-link-eww ()
  (interactive)
  (let ((url (plist-get eww-data :url))
        (title (plist-get eww-data :title)))
    (message "%s" (format (concat title " | " url)))
    (kill-new (format (concat title " | " url)))))

;; (defun title-link-w3m ()
;;   (interactive))

;; URL取得
;; format
