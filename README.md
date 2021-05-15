[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![check](https://github.com/kijimaD/create-link/actions/workflows/test.yml/badge.svg)](https://github.com/kijimaD/create-link/actions/workflows/test.yml)
# 🔗create-link.el

Formatted link generator package for Emacs.

ex. Open the [FSF site](https://www.fsf.org/) on with eww. `M-x create-link` to get a well-formed link(↓Markdown).

`[Front Page — Free Software Foundation — working together for free software](https://www.fsf.org/)`
![Screenshot_2021-05-07_23-29-22](https://user-images.githubusercontent.com/11595790/117464910-1656c680-af8c-11eb-9b9b-c53d65e6f1ea.png)

## 🌟Available buffer

- eww
- w3m
- File (Make format link with buffer and file path. Thanks [sergiruiztrepat](https://github.com/kijimaD/create-link/pull/7#issue-640817593))

## 🖨Output Format

- HTML(default)
- LaTeX
- Markdown
- MediaWiki
- Org-mode

We want to support more formats, please send us your PR! [This PR](https://github.com/kijimaD/create-link/pull/7) may be helpful!

## 🔧Customize

To change the output format:
```elisp
(setq create-link-default-format 'markdown) ;; 'media-wiki 'org
```

## 📋Notes

I wanted to use this↓ useful Chrome extension in Emacs too, so I made it.
- [ku/CreateLink](https://github.com/ku/CreateLink)([Chrome Web Store](https://chrome.google.com/webstore/detail/create-link/gcmghdmnkfdbncmnmlkkglmnnhagajbm))
