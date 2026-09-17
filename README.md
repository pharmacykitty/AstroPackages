# AstroPackages

The shared engine behind two iOS apps, [Astrelia](https://github.com/pharmacykitty/Astrelia) (a planetarium, [on the App Store](https://apps.apple.com/app/id6804829721)) and [Selenia](https://github.com/pharmacykitty/Selenia) (a natal chart app). Both apps pull these packages in by relative path, so this repo has to sit next to them.

## What's in here

**`CelestialCore/`** does the astronomy and nothing else: Julian dates and sidereal time, ΔT, coordinate transforms with precession, nutation and refraction, the Sun and Moon (the Moon uses the full Meeus chapter 47 series), planets through SwiftAA, minor bodies, star and deep-sky catalogs, a bit of astrophysics, and a point octree for culling. No UIKit, no SwiftUI, no sensors, and every type is `Sendable` for Swift 6 strict concurrency.

**`Astrology/`** builds on it: zodiac and houses, aspects with orbs, natal charts, transits, synastry and composites, progressions and returns, plus an interpretation layer written from keyword tables rather than copied text. It depends only on `CelestialCore`, through `../CelestialCore`, so the two folders have to stay side by side.

Swiss Ephemeris isn't used anywhere. Everything is computed from published algorithms and checked against reference values.

## Layout

```
AstroPackages/   ← this repo (keep the folder name)
Astrelia/        → ../AstroPackages/CelestialCore
Selenia/         → ../AstroPackages/CelestialCore and ../AstroPackages/Astrology
```

## Tests

```sh
cd CelestialCore && swift test   # 79 tests, worked examples from Meeus
cd ../Astrology && swift test    # 46 tests
```

Both run on a fresh clone; the first run fetches SwiftAA.

## License

GPL-3.0, see `LICENSE`. Star data from the HYG database stays CC BY-SA 4.0; `NOTICE.md` lists every outside source.
