# AstroPackages

Shared SPM packages for the **Astrolabe** (astronomy) and **Ecliptica** (astrology) apps — sibling repos referenced by relative path (`../AstroPackages/...`). Keep the layout: `CelestialCore/` and `Astrology/` side by side (Astrology depends on `../CelestialCore`).

## Conventions
- Swift 6, strict concurrency. Everything `Sendable`, no global mutable state.
- **No UIKit/SwiftUI/sensor code** — these packages are pure computation.
- Unit tests are mandatory: every transform/ephemeris result validated against a published reference (Meeus worked examples, JPL Horizons, astro.com for cusps).
- Angles/time use explicit types (`Angle`, `JulianDay`) — no naked `Double` in public APIs where avoidable.
- Only external dependency: **SwiftAA (MIT)**. Swiss Ephemeris is banned (AGPL).
- Changing a public API here means rebuilding/checking **both** app repos.
