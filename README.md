# Cycle Boolean

If we consider booleans as integers modulo 2, then incrementing or decrementing is equivalent to flipping between true and false.

It's natural then to want to be able to apply increment and decrement operations to them.

Vim provides increment and decrement operations with [`<C-a>`](https://neovim.io/doc/user/change.html#CTRL-A) and [`<C-x>`](https://neovim.io/doc/user/change.html#CTRL-X) respectively; this plugin expands them to work on booleans.

## Behaviour

When the cursor is over a number, we increment or decrement in exactly the way we normally would were this plugin not installed.

When the cursor is over a word that "looks like" a boolean, we toggle it. Here "looks like" means we compare it to values like `true`, `True`, `yes`, and so on. We don't consider the syntax group or tree-sitter capture to determine this, because we may want to flip booleans inside strings or comments.

## Caveats

Incrementing and decrementing booleans only works in normal mode.

## Alternatives

This isn't a novel idea it seems (https://vi.stackexchange.com/q/5213). It's been implemented by others, in different ways. The below might be better or worse than this plugin.

* [RutaTang/compter.nvim](https://github.com/RutaTang/compter.nvim), more general purpose and configurable,
* [nat-418/boole.nvim](https://github.com/nat-418/boole.nvim), more general purpose and configurable,
* [can3p/incbool.vim](https://github.com/can3p/incbool.vim), doesn't fall back to native increment/decrement behaviour,
* [polirritmico/simple-boolean-toggle.nvim](https://github.com/polirritmico/simple-boolean-toggle.nvim), looks more complex,
* [vim-scripts/Toggle](https://github.com/vim-scripts/Toggle), doesn't use increment/decrement,
* [gerazov/toggle-bool.nvim](https://github.com/gerazov/toggle-bool.nvim), doesn't use increment/decrement.
