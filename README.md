<div align="center">
  <h1>vim-move-window</h1>
  <p>Move windows around using yank and paste</p>
  <p>
    <img src="https://img.shields.io/badge/version-0.1.0--alpha-orange" />
    <a href="https://github.com/MisanthropicBit/vim-move-window/actions?query=workflow%3A%22Run+vader+tests%22">
        <img src="https://img.shields.io/github/workflow/status/MisanthropicBit/vim-move-window/Run%20vader%20tests/master" />
    </a>
    <a href="https://coveralls.io/github/MisanthropicBit/vim-move-window?branch=master">
        <img src="https://coveralls.io/repos/github/MisanthropicBit/vim-move-window/badge.svg?branch=master" alt="Coverage Status" />
    </a>
    <a href="/LICENSE">
        <img
        src="https://img.shields.io/github/license/MisanthropicBit/vim-move-window" />
    </a>
    <img src="https://img.shields.io/badge/compatible-neovim-blueviolet" />
  </p>
</div>

Use `<c-w>yy` to yank the current window and `<c-w>yq` to yank and quit the
current window.

Then navigate to another window and paste the yanked window relative to the
current window using `<c-w>yh` (left), `<c-w>yj` (down), `<c-w>yk` (up), or
`<c-w>yl` (right).

## Installation

* [NeoBundle](https://github.com/Shougo/neobundle.vim):
  `NeoBundle 'MisanthropicBit/vim-move-window'`
* [VAM](https://github.com/MarcWeber/vim-addon-manager):
  `call vam#ActivateAddons(['MisanthropicBit/vim-move-window'])`
* [Vundle](https://github.com/VundleVim/Vundle.vim):
  `Plugin 'MisanthropicBit/vim-move-window'`
* [vim-plug](https://github.com/junegunn/vim-plug):
  `Plug 'MisanthropicBit/vim-move-window'`
