/// A complex type that contains information about a geographic location.
pub const GeoLocation = struct {
    /// The two-letter code for the continent.
    ///
    /// Amazon Route 53 supports the following continent codes:
    ///
    /// * **AF**: Africa
    ///
    /// * **AN**: Antarctica
    ///
    /// * **AS**: Asia
    ///
    /// * **EU**: Europe
    ///
    /// * **OC**: Oceania
    ///
    /// * **NA**: North America
    ///
    /// * **SA**: South America
    ///
    /// Constraint: Specifying `ContinentCode` with either `CountryCode`
    /// or `SubdivisionCode` returns an `InvalidInput` error.
    continent_code: ?[]const u8,

    /// For geolocation resource record sets, the two-letter code for a country.
    ///
    /// Amazon Route 53 uses the two-letter country codes that are specified in [ISO
    /// standard 3166-1
    /// alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2).
    ///
    /// Route 53 also supports the country code **UA** for
    /// Ukraine.
    country_code: ?[]const u8,

    /// For geolocation resource record sets, the two-letter code for a state of the
    /// United
    /// States. Route 53 doesn't support any other values for `SubdivisionCode`. For
    /// a list of state abbreviations, see [Appendix B: Two–Letter State and
    /// Possession Abbreviations](https://pe.usps.com/text/pub28/28apb.htm) on the
    /// United
    /// States Postal Service website.
    ///
    /// If you specify `subdivisioncode`, you must also specify `US` for
    /// `CountryCode`.
    subdivision_code: ?[]const u8,
};
