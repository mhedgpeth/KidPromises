default: core-incremental

clean-xcframework:
    rm -rf apple/shared.xcframework

core-generate-bindings:
    # Using cargo run ensures we use the project's version of uniffi-bindgen
    cd shared && cargo run --bin uniffi-bindgen generate src/shared.udl --language swift --out-dir ../target/bindings-swift

# initializes the core to be able to run and compile
core-initialize:
  rustup target add aarch64-apple-ios
  rustup target add aarch64-apple-darwin
  rustup target add aarch64-apple-ios-sim

# Debug builds - faster compilation, includes debug symbols
core-build-ios-sim-debug:
    cargo build --target aarch64-apple-ios-sim

core-build-ios-debug:
    cargo build --target aarch64-apple-ios

core-build-macos-debug:
    cargo build --target aarch64-apple-darwin

alias cxd := core-create-xcframework-debug

# create xcframework for developing with apple
core-create-xcframework-debug: clean-xcframework core-build-ios-sim-debug core-build-ios-debug core-build-macos-debug core-generate-bindings
    xcodebuild -create-xcframework \
        -library target/aarch64-apple-ios-sim/debug/libshared.a -headers target/bindings-swift \
        -library target/aarch64-apple-ios/debug/libshared.a -headers target/bindings-swift \
        -library target/aarch64-apple-darwin/debug/libshared.a -headers target/bindings-swift \
        -output apple/shared.xcframework

# Release builds - slower compilation, optimized runtime performance
core-build-ios-sim-release:
    cargo build --target aarch64-apple-ios-sim --release

core-build-ios-release:
    cargo build --target aarch64-apple-ios --release

core-build-macos-release:
    cargo build --target aarch64-apple-darwin --release

alias cxr := core-create-xcframework-release

core-create-xcframework-release: clean-xcframework core-build-ios-sim-release core-build-ios-release core-build-macos-release core-generate-bindings
    xcodebuild -create-xcframework \
        -library target/aarch64-apple-ios-sim/release/libshared.a -headers target/bindings-swift \
        -library target/aarch64-apple-ios/release/libshared.a -headers target/bindings-swift \
        -library target/aarch64-apple-darwin/release/libshared.a -headers target/bindings-swift \
        -output apple/shared.xcframework

# cleans the rust core
core-clean: clean-xcframework
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
core-incremental: core-format core-lint core-build core-test core-create-xcframework-debug

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