fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

### generate

```sh
[bundle exec] fastlane generate
```

Generate project files

### lint

```sh
[bundle exec] fastlane lint
```

Lint project

### reformat

```sh
[bundle exec] fastlane reformat
```

Reformat project

### lint_formatting

```sh
[bundle exec] fastlane lint_formatting
```

Ensure project is formatted

### create_app

```sh
[bundle exec] fastlane create_app
```

Create on Developer Portal and App Store Connect

Note that this only works with a personal Apple ID in a local

session and can't be a part of CI

----


## Mac

### mac test

```sh
[bundle exec] fastlane mac test
```

Test

### mac nuke_signing

```sh
[bundle exec] fastlane mac nuke_signing
```

Nuke certs

### mac signing

```sh
[bundle exec] fastlane mac signing
```

Sync signing

### mac build

```sh
[bundle exec] fastlane mac build
```

Build binary

### mac release

```sh
[bundle exec] fastlane mac release
```

Release binary

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
