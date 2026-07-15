# AstroPackages

Two local Swift packages shared by the sibling app repos:

- **`CelestialCore/`** — pure astronomy computation: time (Julian date, sidereal, ΔT), coordinates (equatorial ⇄ horizontal, precession, nutation, refraction), ephemeris (Sun, Moon, planets via SwiftAA, minor bodies), star/deep-sky catalogs, astrophysics, spatial index. No UI, no sensors.
- **`Astrology/`** — zodiac, houses, aspects, charts, transits, synastry, progressions/returns, interpretation. Depends only on `CelestialCore` (relative path `../CelestialCore` — the two packages must stay siblings in this repo).

## Consumers (sibling checkouts, referenced by relative path)

```
~/Developer/
  AstroPackages/   # this repo
  Astrolabe/       # astronomy app  → ../AstroPackages/CelestialCore
  Ecliptica/       # astrology app  → ../AstroPackages/CelestialCore + ../AstroPackages/Astrology
```

All three repos must be checked out as siblings for the apps' XcodeGen specs to resolve.

## Tests

```sh
cd CelestialCore && swift test
cd Astrology && swift test
```

Extracted from the Astrolabe repo (see its history before 2026-07-15 for provenance).
