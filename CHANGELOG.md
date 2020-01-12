# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and this project
adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [2.1.0]

### Added

- Added support for Rails 6!

### Changed

- Rails 5.2.0 is now the minimum required version
- Adopted jsonb for notifications meta

## [2.0.0]

### Changed

- Look for couriers in the root `Hertz` namespace

## [1.0.3]

**This is when we actually started with SemVer.**

### Changed

- Updated and linted codebase

## [1.0.2]

### Added

- Implemented new `#notify` syntax

## [1.0.1]

### Added

- Implemented Deliveries API
- Implemented `email` and `sms` couriers

### Fixed

- Fixed notifications being delivered before DB commit

## [1.0.0]

First stable release.

## [0.1.0]

First public release.

[Unreleased]: https://github.com/aldesantis/hertz/compare/v2.1.0...HEAD
[2.1.0]: https://github.com/aldesantis/hertz/compare/v2.0.0...v2.1.0
[2.0.0]: https://github.com/aldesantis/hertz/compare/v1.0.3...v2.0.0
[1.0.3]: https://github.com/aldesantis/hertz/compare/v1.0.2...v1.0.3
[1.0.2]: https://github.com/aldesantis/hertz/compare/v1.0.1...v1.0.2
[1.0.1]: https://github.com/aldesantis/hertz/compare/v1.0.0...v1.0.1
[1.0.0]: https://github.com/aldesantis/hertz/compare/v0.1.0...v1.0.0
[0.1.0]: https://github.com/aldesantis/hertz/tree/v0.1.0
