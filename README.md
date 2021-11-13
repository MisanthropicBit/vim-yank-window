<div align="center">
  <h1>vim-yank-window</h1>
  <p><i>Move windows around using yank and paste</i></p>
  <p>
    <img src="https://img.shields.io/badge/version-1.0.0-blue" />
    <a href="https://github.com/MisanthropicBit/vim-yank-window/actions?query=workflow%3A%22Run+vader+tests%22">
        <img src="https://img.shields.io/github/workflow/status/MisanthropicBit/vim-yank-window/Run%20vader%20tests/master" />
    </a>
    <a href="https://coveralls.io/github/MisanthropicBit/vim-yank-window?branch=master">
        <img src="https://coveralls.io/repos/github/MisanthropicBit/vim-yank-window/badge.svg?branch=master" alt="Coverage Status" />
    </a>
    <a href="/LICENSE">
        <img
        src="https://img.shields.io/github/license/MisanthropicBit/vim-yank-window" />
    </a>
    <img src="https://img.shields.io/badge/compatible-neovim-blueviolet" />
  </p>
</div>

**Simple usage:**

1. Use `<c-w>yy` to yank the current window or `<c-w>yq` to yank and quit the
   current window.

2. Navigate to another window and paste the yanked window relative to it:
   * `<c-w>yh` (left)
   * `<c-w>yj` (down)
   * `<c-w>yk` (up)
   * `<c-w>yl` (right)
   * `<c-w>yt` (a new tab page after the current one)
   * `<c-w>yT` (a new tab page before the current one)

## Installation

* [NeoBundle](https://github.com/Shougo/neobundle.vim):
  `NeoBundle 'MisanthropicBit/vim-yank-window'`
* [VAM](https://github.com/MarcWeber/vim-addon-manager):
  `call vam#ActivateAddons(['MisanthropicBit/vim-yank-window'])`
* [Vundle](https://github.com/VundleVim/Vundle.vim):
  `Plugin 'MisanthropicBit/vim-yank-window'`
* [vim-plug](https://github.com/junegunn/vim-plug):
  `Plug 'MisanthropicBit/vim-yank-window'`
