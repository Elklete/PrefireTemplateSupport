# Upstream provenance

`PrefireTemplateSupport` is a focused source distribution for Prefire's template
generator. It is a fresh repository, not a GitHub fork. The production source
files below are copied verbatim from the pinned upstream revisions.

| Module | Upstream repository | Release | Revision | License |
| --- | --- | --- | --- | --- |
| `PathKit` | https://github.com/kylef/PathKit | 1.0.1 | `3bfd2737b700b9a36565a8c94f4ad2b050a5e574` | BSD-2-Clause |
| `Stencil` | https://github.com/stencilproject/Stencil | 0.15.1 | `4f222ac85d673f35df29962fc4c36ccfdaf9da5b` | BSD-2-Clause |
| `StencilSwiftKit` | https://github.com/SwiftGen/StencilSwiftKit | 2.10.1 | `20e2de5322c83df005939d9d9300fab130b49f97` | MIT |

The complete upstream license notices are preserved in `Licenses/`, and source
file copyright headers remain intact. This package intentionally omits upstream
test-only and development-hook dependencies: Spectre, Komondor, PackageConfig,
and ShellOut. The bundled sources do not import or use them.

## Updating the vendored sources

Updates are deliberate compatibility changes: select upstream revisions, copy
their production sources, update this table and any focused XCTest coverage,
publish a new immutable package tag, then update Prefire's exact dependency and
rebuild its bundled generator.
