# Third-party notices

The code in this repository is licensed under the GNU General Public License v3.0 (see `LICENSE`). A few pieces come from other people and keep their own terms.

## Data

**HYG star database** by David Nash (astronexus), CC BY-SA 4.0.
https://github.com/astronexus/HYG-Database
`CelestialCore` parses HYG CSV files, and the test fixture in `CelestialCore/Tests/CelestialCoreTests/StarCatalogTests.swift` contains four rows of HYG data. Those rows are shared under CC BY-SA 4.0, not the GPL.

**Astronomical Algorithms** (2nd ed.) by Jean Meeus. The formulas, the worked examples used as test references, the nutation table (22.A) and the lunar series (chapter 47) are implemented from the book.

**ΔT polynomials** from Espenak & Meeus, *Five Millennium Canon of Solar Eclipses* (NASA/TP-2006-214141), public domain.

**Meteor shower data** follows the International Meteor Organization's working list.

## Dependencies (fetched by Swift Package Manager, not copied here)

**SwiftAA** by Cédric Foellmi, MIT License. https://github.com/onekiloparsec/SwiftAA
SwiftAA wraps **AA+** by P.J. Naughter, which has its own license: http://www.naughter.com/aa.html
