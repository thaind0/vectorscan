# `vectorscan-rs`

[![Crates.io](https://img.shields.io/crates/v/vectorscan)](https://crates.io/crates/vectorscan)

## Overview

This crate implements minimal Rust bindings to the [Vectorscan](https://github.com/Vectorcamp/vectorscan) fork of [Hyperscan](https://github.com/intel/hyperscan), the high-performance regular expression engine.

This crate builds a vendored copy of Vectorscan from source.

## Prerequisites

To build this crate, you need CMake.
Additionally, if you build with the `gen` feature enabled, you will need Clang installed so that `bindgen` can produce the raw Rust bindings to Vectorscan.

This has been tested on x86_64 Linux and Intel and ARM macOS.

## Implementation Notes

This crate was adapted from the [pyperscan](https://github.com/vlaci/pyperscan) project, which uses Rust to expose Hyperscan to Python.

The bindings implemented here expose just the parts of Vectorscan that are needed by Nosey Parker, specifically, the block-based matching APIs.
The various other APIs such as stream- and vector-based matching are not exposed.
Other features too, like the Chimera PCRE library, test code, benchmark code, and supporting utilities are disabled.

The source of Vectorscan 5.4.11 is included here in the `vectorscan-sys` directory.

The Vectorscan sources were patched for a few reasons:

- Its CMake-based build system was modified to eliminate the build-time dependency on `ragel`
- 4 Ragel `.rl` files were precompiled once and added to the source tree
- Its build system was modified to allow disabling the build of additional components
- Its build system was modified to disable `-Werror` in all cases

These modifications are not represented as explicit patch files that get applied at build time.
Instead, the modifications were made directly to the vendored source tree.
This was an expedient approach, but something that should be reworked if additional changes to the `vectorscan` sources are needed.

## Licensing

Vectorscan is released under a 3-clause BSD license.
pyperscan is released under the Apache License Version 2.0 or the MIT license.
Boost is released under the Boost License Version 1.0.

## Binding with bindgen

### Install bindgen

```
cargo install bindgen # if not already installed
```

### Configure cmake

```
mkdir build
cd build
cmake ../vectorscan-sys
```

### copy hs_version.h from build directory to vectorscan-sys/src

```
cp hs_version.h ../vectorscan-sys/src # from build directory
```

### Generate bindings

```
bindgen vectorscan-sys/src/hs.h -o src/bindings.rs # from root directory
```
