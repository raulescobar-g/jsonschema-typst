#!/usr/bin/env zsh 

RUSTFLAGS='--cfg getrandom_backend="custom"' cargo build --release --target wasm32-unknown-unknown;
cp ./target/wasm32-unknown-unknown/release/jsonschema.wasm ./typst-package

