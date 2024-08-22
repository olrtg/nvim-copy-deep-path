<!-- markdownlint-disable MD033 MD041-->
<h3 align="center">
  nvim-copy-deep-path
</h3>

<p align="center">
  Copy the path of deeply nested keys from JSON/YAML files.
</p>

## Installation

With lazy.nvim:

```lua
{ "olrtg/nvim-copy-deep-path", config = true }
```

This will add the `:CopyDeepPath` command to your Neovim.

## Usage

Let's say you have a JSON file with the following structure:

```json
{
  "foo": {
    "bar": {
      "baz": "qux"
    }
  }
}
```

With the cursor on the `baz` key, you can run `:CopyDeepPath` to copy the path
`foo.bar.baz` to the clipboard.
