import XCTest
@testable import CelestialCore

final class VisibleSkyTests: XCTestCase {
    // New York, around local apparent noon (17:00 UTC) on a summer day.
    private let nyc = GeographicLocation(latitude: .degrees(40.71), longitude: .degrees(-74.0))
    private var noonUTC: Date {
        var c = DateComponents(); c.year = 2026; c.month = 6; c.day = 21; c.hour = 17
        c.timeZone = TimeZone(identifier: "UTC")
        return Calendar(identifier: .gregorian).date(from: c)!
    }

    func testStatusCoversSunMoonAndFivePlanets() {
        let s = VisibleSky.status(at: nyc, date: noonUTC)
        XCTAssertEqual(s.count, 7)                       // Sun, Moon, 5 naked-eye planets
        XCTAssertEqual(s.first?.name, "Sun")
        XCTAssertTrue(s.contains { $0.name == "Saturn" })
    }

    func testSunIsUpAndSetsLaterAtMiddayNYC() {
        let sun = VisibleSky.status(at: nyc, date: noonUTC).first { $0.name == "Sun" }!
        XCTAssertTrue(sun.isUp)                           // midday: above the horizon
        XCTAssertGreaterThan(sun.altitude.degrees, 0)
        XCTAssertNotNil(sun.nextSet)                      // sets this evening
        if let set = sun.nextSet {
            let hours = set.timeIntervalSince(noonUTC) / 3600
            XCTAssertTrue(hours > 0 && hours < 12, "Sun should set within 12h of local noon")
        }
    }

    // MARK: Reference rise/set times (timeanddate.com, USNO conventions,
    // New York 2026-07-30 EDT): sunrise 05:50, sunset 20:13; moonset 06:40,
    // moonrise 20:57. Queried from 05:00 UTC (01:00 EDT) that morning.

    private var earlyJul30UTC: Date {
        var c = DateComponents(); c.year = 2026; c.month = 7; c.day = 30; c.hour = 5
        c.timeZone = TimeZone(identifier: "UTC")
        return Calendar(identifier: .gregorian).date(from: c)!
    }

    private func utc(_ day: Int, _ hour: Int, _ minute: Int) -> Date {
        var c = DateComponents(); c.year = 2026; c.month = 7; c.day = day
        c.hour = hour; c.minute = minute
        c.timeZone = TimeZone(identifier: "UTC")
        return Calendar(identifier: .gregorian).date(from: c)!
    }

    /// The Sun's −50′ horizon (limb + refraction): almanac agreement to ±2 min.
    func testSunriseSunsetMatchAlmanacNYC() {
        let sun = VisibleSky.status(at: nyc, date: earlyJul30UTC).first { $0.name == "Sun" }!
        XCTAssertEqual(sun.nextRise!.timeIntervalSince(utc(30, 9, 50)), 0, accuracy: 120)
        XCTAssertEqual(sun.nextSet!.timeIntervalSince(utc(31, 0, 13)), 0, accuracy: 120)
    }

    /// The Moon's +0.125° geocentric horizon (mean parallax): the actual parallax
    /// varies with distance, so allow ±6 min against the almanac.
    func testMoonRiseSetMatchAlmanacNYC() {
        let moon = VisibleSky.status(at: nyc, date: earlyJul30UTC).first { $0.name == "Moon" }!
        XCTAssertEqual(moon.nextSet!.timeIntervalSince(utc(30, 10, 40)), 0, accuracy: 360)
        XCTAssertEqual(moon.nextRise!.timeIntervalSince(utc(31, 0, 57)), 0, accuracy: 360)
    }

    func testMoonPhaseFractionInRange() {
        let p = VisibleSky.moonPhase(at: noonUTC)
        XCTAssertGreaterThanOrEqual(p.illuminatedFraction, 0)
        XCTAssertLessThanOrEqual(p.illuminatedFraction, 1)
        XCTAssertFalse(p.name.isEmpty)
    }
}
