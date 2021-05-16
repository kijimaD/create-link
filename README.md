[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![check](https://github.com/kijimaD/create-link/actions/workflows/test.yml/badge.svg)](https://github.com/kijimaD/create-link/actions/workflows/test.yml)
# 🔗create-link.el

Formatted link generator package for Emacs.

e.g. Open [Google](https://google.com) on with `eww`. Then `M-x create-link` to get a formatted link(↓HTML).

![eww-draw](https://user-images.githubusercontent.com/11595790/118385727-86c8ac00-b64c-11eb-9be7-724f3eaf2fdc.png)

e.g. Point on URL `M-x create-link`, fill title with scraped one.

![title-from-link-draw](https://user-images.githubusercontent.com/11595790/118385789-15d5c400-b64d-11eb-9380-2e6b786f41c3.png)

## 🌟Available buffer

- eww
- w3m
- File (Make format link with buffer and file path. Thanks [sergiruiztrepat](https://github.com/kijimaD/create-link/pull/7#issue-640817593))

## 🖨Output Format

- HTML(default)
- LaTeX
- Markdown
- DokuWiki
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
