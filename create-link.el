;;; create-link.el --- Formatted link generator package for Emacs.

;; Copyright (C) 2021 Kijima Daigo
;; Created date 2021-05-07 00:30 +0900

;; Author: Kijima Daigo <norimaking777@gmail.com>
;; Version: 1.0.0
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
;; Creat formatted url on current page.
;; M-x create-link
;; ex. https://www.fsf.org/ => [Front Page — Free Software Foundation — working together for free software](https://www.fsf.org/)

;;; Code:

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

;; Format keywords:
;; %url%
;; %title%
(defcustom create-link-format-html "<a href='%url%'>%title%</a>"
  "HTML link format.")

(defcustom create-link-format-markdown "[%title%](%url%)"
  "Markdown link format.")

(defcustom create-link-format-org "[[%url%][%title%]]"
  "Org-mode link format")

(defcustom create-link-format-media-wiki "[%url% %title%]"
  "Media Wiki link format")

(defun create-link-raw-format ()
  "Output default format string."
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

(defun create-link-make-format ()
  "Fill format keywords."
  (replace-regexp-in-string
   "%title%"
   (cdr (assoc 'title (create-link-browser)))
   (replace-regexp-in-string
    "%url%"
    (cdr (assoc 'url (create-link-browser)))
    (create-link-raw-format))))

(defun create-link-browser ()
  "Get keyword information(ex. link) on your browser."
  (cond ((string-match-p "eww" (buffer-name))
         `((title . ,(plist-get eww-data :title))
           (url . ,(plist-get eww-data :url))))
        ((string-match-p "w3m" (buffer-name))
         `((title . ,w3m-current-title)
           (url . ,w3m-current-url)))
        (t (message "Can't create link!"))))

;;;###autoload
(defun create-link ()
  "Create formatted link."
  (interactive)
  (message "Copied! %s" (create-link-make-format))
  (kill-new (create-link-make-format)))

(provide 'crate-link)

;;; create-link.el ends here
