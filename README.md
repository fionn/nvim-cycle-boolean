# Cycle Boolean

If we consider booleans as integers modulo 2, then incrementing or decrementing is equivalent to flipping between true and false.

It's natural then to want to be able to apply increment and decrement operations to them.

Vim provides increment and decrement operations with [`<C-a>`](https://neovim.io/doc/user/change.html#CTRL-A) and [`<C-x>`](https://neovim.io/doc/user/change.html#CTRL-X) respectively; this plugin expands them to work on booleans.

## Behaviour

When the cursor is over a number, we increment or decrement in exactly the way we normally would were this plugin not installed.

When the cursor is over a word that "looks like" a boolean, we toggle it. Here "looks like" means we compare it to values like `true`, `True`, `yes`, and so on. We don't consider the syntax group or tree-sitter capture to determine this, because we may want to flip booleans inside strings or comments.

This also works as expected in visual and visual-block mode.
