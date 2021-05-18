;;; create-link.el --- Formatted link generator in browser

;; Copyright (C) 2021 Kijima Daigo
;; Created date 2021-05-07 00:30 +0900

;; Author: Kijima Daigo <norimaking777@gmail.com>
;; Version: 1.0.0
;; Package-Requires: ((emacs "25.1") (request "0.3.2"))
;; Keywords: link format browser convenience
;; URL: https://github.com/kijimaD/create-link

;; This file is NOT part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:
;; Creat formatted url on current buffer(w3m, eww).
;; M-x create-link

;;; Code:

(require 'cl-lib)
(require 'eww)
(require 'request)
(require 'thingatpt)
(require 'w3m)

(defgroup create-link nil
  "Generate a formatted current page link."
  :group 'convenience
  :prefix "create-link-")

(defcustom create-link-default-format 'create-link-format-html
  "Default link format."
  :group 'create-link
  :type '(choice (const :tag "HTML" create-link-format-html)
                 (const :tag "Markdown" create-link-format-markdown)
                 (const :tag "Org"  create-link-format-org)
                 (const :tag "DokuWiki" create-link-format-doku-wiki)
                 (const :tag "MediaWiki" create-link-format-media-wiki)
	         (const :tag "LaTeX" create-link-format-latex)))

;; Format keywords:
;; %url% - http://www.google.com/
;; %title% - Google
(defcustom create-link-format-html "<a href='%url%'>%title%</a>"
  "HTML link format."
  :group 'create-link
  :type 'string)

(defcustom create-link-format-markdown "[%title%](%url%)"
  "Markdown link format."
  :group 'create-link
  :type 'string)

(defcustom create-link-format-org "[[%url%][%title%]]"
  "Org-mode link format."
  :group 'create-link
  :type 'string)

(defcustom create-link-format-doku-wiki "[[%url%|%title%]]"
  "DokuWiki link format."
  :group 'create-link
  :type 'string)

(defcustom create-link-format-media-wiki "[%url% %title%]"
  "MediaWiki link format."
  :group 'create-link
  :type 'string)

(defcustom create-link-format-latex "\\href{%url%}{%title%}"
  "Latex link format."
  :group 'create-link
  :type 'string)

(defconst create-link-formats
  '((create-link-format-html)
    (create-link-format-markdown)
    (create-link-format-org)
    (create-link-format-doku-wiki)
    (create-link-format-media-wiki)
    (create-link-format-latex))
  "All format list.  Use for completion.")

(defcustom create-link-filter-title-regexp "<.*>"
  "Filter title regexp.
Replace all matches for `create-link-filter-title-regexp' with
`create-link-filter-title-replace'."
  :group 'create-link
  :type 'regexp)

(defcustom create-link-filter-title-replace ""
  "Filter title replace.
Replace all matches for `create-link-filter-title-regexp' with
`create-link-filter-title-replace'."
  :group 'create-link
  :type 'string)

(defvar create-link-scraped-title ""
  "Variable to save scraped title.")

(defun create-link-replace-dictionary ()
  "Convert format keyword to corresponding one.
If there is a selected region, fill title with the region.
If point is on URL, fill title with scraped one."
  (cond ((region-active-p)
         (deactivate-mark t)
         `(("%url%" . ,(cdr (assoc 'url (create-link-get-information))))
           ("%title%" . ,(buffer-substring-no-properties (region-beginning) (region-end)))))
        ((thing-at-point-url-at-point)
         `(("%url%" . ,(thing-at-point-url-at-point))
           ("%title%" . ,(create-link-from-url))))
        (t
         `(("%url%" . ,(cdr (assoc 'url (create-link-get-information))))
           ("%title%" . ,(create-link-filter-title))))))

(defun create-link-from-url ()
  "Get title from current point url."
  (request (thing-at-point-url-at-point)
           :parser 'buffer-string
           :success (cl-function
                     (lambda (&key data &allow-other-keys)
                       (string-match "<title>\\(.*\\)</title>" data)
                       (setq create-link-scraped-title (match-string 1 data)))))
  (sit-for 1)
  create-link-scraped-title)

(defun create-link-filter-title ()
  "Filter title information.
Replace all matches for`create-link-filter-title-regexp' with
`create-link-filter-title-replace'."
  (replace-regexp-in-string
   create-link-filter-title-regexp
   create-link-filter-title-replace
   (cdr (assoc 'title (create-link-get-information)))))

(defun create-link-make-format (&optional format)
  "Fill format keywords by FORMAT(optional).
If FORMAT is not specified, use `create-link-default-format'"
  (seq-reduce
   (lambda (string regexp-replacement-pair)
     (replace-regexp-in-string
      (car regexp-replacement-pair)
      (cdr regexp-replacement-pair)
      string))
   (create-link-replace-dictionary)
   (if format (eval format)
     (eval create-link-default-format))))

(defun create-link-get-information ()
  "Get keyword information on your browser."
  (cond ((string-match-p "eww" (buffer-name))
         (if (require 'eww nil 'noerror)
             `((title . ,(plist-get eww-data :title))
               (url . ,(eww-current-url)))))
        ((string-match-p "w3m" (buffer-name))
         (if (require 'w3m nil 'noerror)
             `((title . ,(w3m-current-title))
               (url . ,w3m-current-url))))
        ;; otherwise, create-link to the file-buffer
        (t
         `((title . ,(buffer-name))
	   (url . ,(buffer-file-name))))))

;;;###autoload
(defun create-link-manual ()
  "Manually select a format and generate a link.
Version of function `create-link'."
  (interactive)
  (create-link
   (intern
    (completing-read "Format: " create-link-formats nil t nil))))

;;;###autoload
(defun create-link (&optional format)
  "Create format link.
If an optional FORMAT is specified,
it will be generated in that format."
  (interactive)
  (message "Copied! %s" (create-link-make-format format))
  (kill-new (create-link-make-format format)))

(provide 'create-link)

;;; create-link.el ends here
