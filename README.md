[![MELPA](https://melpa.org/packages/create-link-badge.svg)](https://melpa.org/#/create-link)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![check](https://github.com/kijimaD/create-link/actions/workflows/test.yml/badge.svg)](https://github.com/kijimaD/create-link/actions/workflows/test.yml)
# create-link.el

Smart format link generator package for Emacs.
This package adds two smart link generate functions, `(create-link)` and `(create-link-manual)`

e.g. Put cursor on URL and `M-x create-link` to get format link with title filling with scraped one.
- `http://example.com` → `<a href="http://example.com/">Example Domain</a>`

![rsz_11118385789-15d5c400-b64d-11eb-9380-2e6b786f41c3](https://user-images.githubusercontent.com/11595790/119352549-ca6e8600-bcdc-11eb-99ca-ec71594d14af.png)

e.g. Open [Google](https://google.com) on with `eww`. Then `M-x create-link` to get a formatted link(↓HTML).

![rsz_1118385727-86c8ac00-b64c-11eb-9be7-724f3eaf2fdc](https://user-images.githubusercontent.com/11595790/119352489-b4f95c00-bcdc-11eb-9bc3-82c134e4a69e.png)

e.g. Put cursor on format link and `M-x create-link-manual` to convert to any format you choose.

- `<a href="http://example.com/">Example Domain</a>` → `[[http://example.com/][Example Domain]]`

## 🖨Output Format

- HTML(default)
- LaTeX
- Markdown
- DokuWiki
- MediaWiki
- Org-mode

I want to support more formats, please send us your PR! [This PR](https://github.com/kijimaD/create-link/pull/7) may be helpful!

## 🔌Context

- Region active: Use region text for title
- On format link: Convert link
- On URL: Use scraping title
- Specific buffer
  - eww
  - w3m
  - File (Make format link with buffer and file path. Thanks [sergiruiztrepat](https://github.com/kijimaD/create-link/pull/7#issue-640817593))

## 🔧Customize

To change the default output format:
```elisp
(setq create-link-default-format 'markdown) ;; 'media-wiki 'org
```

## 💡Image

[![](https://mermaid.ink/img/eyJjb2RlIjoiZ3JhcGggVERcbiAgICBBW1wiKGNyZWF0ZS1saW5rKSBvciAoY3JlYXRlLWxpbmstbWFudWFsKVwiXSAtLT4gQyhbPEN1cnJlbnQgcG9pbnQgaXMuLi4-XSlcbiAgICBDIC0tPiBEW1JlZ2lvbiBhY3RpdmU_XVxuICAgIEQgLS0-IHxVc2UgcmVnaW9uIHdpdGggdGl0bGV8Rk9STUFUW09VVFBVVF1cbiAgICBEIC0tPiB8Tm98IEVbTGluayBmb3JtYXRzP11cbiAgICBFIC0tPiB8Q29udmVydHxGT1JNQVRcbiAgICBFIC0tPiB8Tm98IEZbVVJMP11cbiAgICBGIC0tPiB8VXNlIHNjcmFwaW5nIHRpdGxlIHdpdGggdXJsfEZPUk1BVFxuICAgIEYgLS0-IHxOb3wgRyhbPEJ1ZmZlciBpcy4uLj5dKVxuICAgIEcgLS0-IEhbZXd3P11cbiAgICBIIC0tPiB8R2V0IGxpbmsgZGF0YXxGT1JNQVRcbiAgICBIIC0tPiB8Tm98SVt3M20_XVxuICAgIEkgLS0-IHxHZXQgbGluayBkYXRhfEZPUk1BVFxuICAgIEkgLS0-IHxOb3xKW0ZpbGUgYnVmZmVyP11cbiAgICBKIC0tPiB8R2V0IEZpbGUgZGF0YXxGT1JNQVQiLCJtZXJtYWlkIjp7fSwidXBkYXRlRWRpdG9yIjpmYWxzZX0)](https://mermaid-js.github.io/mermaid-live-editor/#/edit/eyJjb2RlIjoiZ3JhcGggVERcbiAgICBBW1wiKGNyZWF0ZS1saW5rKSBvciAoY3JlYXRlLWxpbmstbWFudWFsKVwiXSAtLT4gQyhbPEN1cnJlbnQgcG9pbnQgaXMuLi4-XSlcbiAgICBDIC0tPiBEW1JlZ2lvbiBhY3RpdmU_XVxuICAgIEQgLS0-IHxVc2UgcmVnaW9uIHdpdGggdGl0bGV8Rk9STUFUW09VVFBVVF1cbiAgICBEIC0tPiB8Tm98IEVbTGluayBmb3JtYXRzP11cbiAgICBFIC0tPiB8Q29udmVydHxGT1JNQVRcbiAgICBFIC0tPiB8Tm98IEZbVVJMP11cbiAgICBGIC0tPiB8VXNlIHNjcmFwaW5nIHRpdGxlIHdpdGggdXJsfEZPUk1BVFxuICAgIEYgLS0-IHxOb3wgRyhbPEJ1ZmZlciBpcy4uLj5dKVxuICAgIEcgLS0-IEhbZXd3P11cbiAgICBIIC0tPiB8R2V0IGxpbmsgZGF0YXxGT1JNQVRcbiAgICBIIC0tPiB8Tm98SVt3M20_XVxuICAgIEkgLS0-IHxHZXQgbGluayBkYXRhfEZPUk1BVFxuICAgIEkgLS0-IHxOb3xKW0ZpbGUgYnVmZmVyP11cbiAgICBKIC0tPiB8R2V0IEZpbGUgZGF0YXxGT1JNQVQiLCJtZXJtYWlkIjp7fSwidXBkYXRlRWRpdG9yIjpmYWxzZX0)

## 📋Notes

I wanted to use this↓ useful Chrome extension in Emacs too, so I made it.
- [ku/CreateLink](https://github.com/ku/CreateLink)([Chrome Web Store](https://chrome.google.com/webstore/detail/create-link/gcmghdmnkfdbncmnmlkkglmnnhagajbm))
