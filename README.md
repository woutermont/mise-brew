
# mise-brew

A [Homebrew](https://brew.sh/) backend plugin for the [Mise](https://mise.jdx.dev/) version manager


## Installation

This plugin requires [Mise](https://mise.jdx.dev/installing-mise.html) and [Homebrew](https://docs.brew.sh/Installation).

```
mise plugins install brew https://github.com/woutermont/mise-brew
```


## Usage examples

### With mise cli

```
mise install brew:<tool>
mise use brew:<tool>@<version>
```

### In mise config file (`mise.toml`)

```
[tools]
"brew:<tool>" = "<version>"
```

