# Partshell

Partshell is a Vim plugin that adds helper commands for working with shell commands in Vim. For example, `:Shgrep` is an easy way to use any `grep` program, the same way Vim's builtin `:grep` command works. For example, `:Shgrep rg --vimgrep foo` will use [`ripgrep`](https://github.com/BurntSushi/ripgrep).

## Advantages

A couple of general advantages of the Partshell approach when compared to other existing solutions to the same problems:

1. **Flexibility:** For example, [`pbpaste`](https://ss64.com/mac/pbpaste.html) on macOS outputs the clipboard contents, so with `:Shgrep pbpaste` Vim will parse `grep` output from the clipboard (e.g., the built-in `:grep` command with the `'grepprg'` variable make this more difficult).
2. **Repeatability:** Since this approach only runs commands with arguments from the command line, like `:Shgrep fd partshell`, it's easy to repeat (or refine) previous commands using Vim's command line history by hitting up arrow (e.g., as opposed to fuzzy finders, which present a custom UI, if you want to re-open the same file you have to go through that UI every time).

## Notes

Adding a bang (`!`), does the same behavior as the equivalent Vim built-in command (when the internal command supports one). For example, `:Shgrep!` won't automatically jump to the first match, just like `:grep!`.

## `:Shargs[!]`

Wrapper around `:args`.

Populates the argument list with the result of a shell command. Each line is interpreted as a path to a file (a NULL byte terminates input).

### Example

`:Shargs fd partshell` uses [`fd`](https://github.com/sharkdp/fd) to populate the argument list with all the files with `partshell` in the name (recursively from the current directory, because the way `fd` works by default).

#### Built-In Alternative

<p><code>args `fd partshell`</code> (but this won't handle matches with spaces in their filenames properly).</p>

## Grep

### `:Shgrep[!]`

Run the builtin `:grep` command using the arguments as `'grepprg'`. This populates the quickfix list with the matching lines using `'grepformat'`. With a bang (`!`), it doesn't automatically jump to the first match.

#### Example

`:Shgrep rg --vimgrep partshell` uses [ripgrep](https://github.com/BurntSushi/ripgrep) to populate the quickfix list with all the lines that contain `partshell` (recursively from the current directory, because the way `rg` works by default).

#### Built-In Alternative

`:set grepprg=rg\ --vimgrep | grep partshell` but that has the side effect of setting `'grepprg'` (which might be desirable! Setting `'grepprg'` to `rg` is a great alternative if the built-in `:grep` behavior isn't useful).

`:cexpr system('rg --vimgrep partshell')` will also likely work, although technically this uses `'errorformat'` instead of `'grepformat'` to parse matching lines (note that `%`, which can usually be used on the command line to reference the current file, will not work in this context).

### `:Shlgrep[!]`

The same as `:Grepsh` but populate the location list instead.

## Make

### `:Shmake[!]`

Run the builtin `:make` command using the arguments as `'makeprg'`. This populates the quickfix list with the lines with errors using `'errorformat'`. With a bang (`!`), it doesn't automatically jump to the first match.

#### Example

`:Shmake clang %` compiles the current file with `clang`.

#### Built-In Alternative

`:set makeprg=clang\ % | make')` does not set `'makeprg'`.

`:cexpr system('clang hello_world.c')` will also work (although `%` to reference the current file will not work in this context).

### `:Shlmake[!]`

## New Window

Commands that create a new buffer containing the output of a shell command.

The buffer will be named after the shell command, for example `Shnew git show` will create a buffer named `git show`. With a bang (`!`) the same buffer will be re-used for subsequent runs (without a bang, a new buffer will be created appending a number to the end, e.g., `git show 2`).

### Example

`:Shnew git diff` to create a new diff buffer containing the output of `git diff`.

### Built-In Alternative

`:new | r !git diff` but this adds an extra new line at the top and bottom of the output, and doesn't detect the file type. To solve these issues `:new | 0r !git diff ^J norm Gddgg | filetype detect` should work but doesn't seem to in practice (`^J` means do `CTRL-V_CTRL-J` which is the command separator to use after a `:!` to perform a another Vim command instead of piping to a shell command).

### `:Shenew[!]`

Open a new buffer containing the result of a shell command (like `:enew` this will fail unless unless `'hidden'` is set or `'autowriteall'` is set and the file can be written).

### `:Shnew[!]`

Open a new buffer in a new window containing the result of a shell command.

### `:Shtabnew[!]`, `:Shtabedit[!]`

Open a new buffer on a new tab page containing the result of a shell command.

### `:Shvnew[!]`

Like `:Shnew[!]` but split vertically.

## `:P`

`:P` (stands for "partial") takes a command, and that command's arguments, as its arguments, and applies that command the visual selection. This is similar to the builtin support for running commands on a range, `'<,'><command>`, the builtin range support *only works on full lines*, whereas the `:P` command also works on visual selections consisting of partial lines. Vim does not have a builtin way to apply a command to a selection that consists of partial lines. So if part of a line is selected with `v` or `CTRL-v`, `'<,'><command>` will still apply the command to the full line, whereas the `:P` command will only apply command to the selected part of the line.

Using `:P !<shell-command>` will run a shell command on the visual selection.

The inspiration for `:P`, as well implementation ideas, came from the `:B` in the [vis](https://www.vim.org/scripts/script.php?script_id=1195) plugin.

The command passed as an argument to `:P` must support ranges.

### Example



### Built-In Alternative

Copy the selection to a new buffer, and apply the command there (this is also how `P` works internally).
