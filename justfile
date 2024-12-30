default: core-incremental

# cleans the rust core
core-clean:
    rm -rf ./target
    cargo clean

# builds the rust core
core-build:
    cargo build --all

# builds the rust core in release mode
core-build-release:
    cargo build --release --all

# tests the rust core
core-test:
    cargo nextest run

# reformats the rust core to fit standards
core-format:
    cargo fmt

# checks that all core files are formatted to standard
core-format-check:
    cargo fmt --all -- --check

# lints the core
core-lint:
    cargo clippy --all --all-targets -- -D warnings -A clippy::empty_line_after_doc_comments

alias c := core-incremental

# runs an incremental (local) build on the core
core-incremental: core-format core-lint core-build core-test

core-full: core-clean core-format-check core-lint core-build-release core-test

# generates the apple project
apple-generate:
  cd apple && source ./fastlane/.env && xcodegen generate

# builds the apple project
apple-build:
    @echo '{{ style("command") }}apple-build:{{ NORMAL }}'
    cd apple && fastlane mac build

alias af := apple-reformat

# formats all code for the apple project
apple-reformat:
    @echo '{{ style("command") }}apple-format:{{ NORMAL }}'
    cd apple && fastlane reformat

alias al := apple-lint

# lints all swift code for apple
apple-lint:
    @echo '{{ style("command") }}apple-lint:{{ NORMAL }}'
    cd apple && fastlane lint

alias f := all-full

# runs all builds for everything, from a clean start
all-full: core-full apple-build