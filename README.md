# Dev Container Feature: Jetify Devbox

This repository provides a [Dev Container Feature](https://containers.dev/implementors/features/) that installs [Devbox](https://jetpack.io/devbox) in your development container. Devbox is a command-line tool that lets you create isolated shells for development.

## Usage

To use the feature in your devcontainer, add it to your `devcontainer.json`:

```jsonc
{
    "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
    "features": {
        "ghcr.io/righteouslabs/devcontainer-jetify-devbox/devbox:1": {
            "initRepo": true
        }
    }
}
```

## Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| initRepo | boolean | true | Initialize the repository by running 'devbox update' from the root of the repository. This relies on 'devbox.json' file being present in the root of the repository. |

## Prerequisites

- The feature requires the Nix package manager and automatically installs it as a dependency.
- For initialization (`initRepo: true`), a `devbox.json` file must be present in the root of your repository.

## How it works

1. Installs Devbox using Nix
2. If `initRepo` is true and a `devbox.json` file exists in your repository:
   - Changes to the repository root
   - Runs `devbox update` to initialize the development environment

## Repository Structure

This repository follows the standard [dev container Feature](https://containers.dev/implementors/features/) structure:

```
.
├── src
│   └── devbox
│       ├── devcontainer-feature.json  # Feature metadata and options
│       └── install.sh                 # Installation script
└── test
    └── devbox                        # Feature-specific tests
        ├── scenarios.json            # Test scenarios
        └── test.sh                   # Test script
```

## Development

### Testing

The feature includes automated tests that verify:
1. Devbox installation
2. Basic functionality
3. Initialization behavior with and without `devbox.json`

To run the tests locally:

```bash
devcontainer features test -f devbox .
```

## Publishing

This feature is published to GitHub Container Registry (GHCR) and follows [semantic versioning](https://containers.dev/implementors/features/#versioning). You can find the latest version at:

```
ghcr.io/righteouslabs/devcontainer-jetify-devbox/devbox:1
```

### Using in GitHub Codespaces

The feature is publicly available and can be used directly in GitHub Codespaces without any additional configuration. Simply add it to your `devcontainer.json` as shown in the Usage section above.

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add or update tests as needed
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
