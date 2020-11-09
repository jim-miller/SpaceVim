---
title: "SpaceVim lang#scala layer"
description: "This layer is for Scala development"
---

# [Available Layers](../../) >> lang#scala

<!-- vim-markdown-toc GFM -->

- [Description](#description)
- [Features](#features)
- [Install](#install)
  - [Metals](#metals)
- [Key bindings](#key-bindings)

<!-- vim-markdown-toc -->

## Description

This layer adds Scala language support to SpaceVim. This layer includes the [vim-scala](https://github.com/derekwyatt/vim-scala) plugin.

## Features

- syntax highlighting
- indent
- sbt compiler
- soring imports
- tagbar support

## Install

To use this configuration layer, update custom configuration file with:

```toml
[[layers]]
  name = "lang#scala"
```

### Metals
If you choose “coc” as your auto completion engine, you must run “:CocInstall coc-metals” to install the extension.

## Key bindings

**Import key bindings:**

| Key Bindings | Descriptions              |
| ------------ | ------------------------- |
| `SPC l f`    | format current file       |
| `SPC l g g`  | go to definition          |
