/// A complex type that contains the codes and full continent, country, and
/// subdivision
/// names for the specified `geolocation` code.
pub const GeoLocationDetails = struct {
    /// The two-letter code for the continent.
    continent_code: ?[]const u8 = null,

    /// The full name of the continent.
    continent_name: ?[]const u8 = null,

    /// The two-letter code for the country.
    country_code: ?[]const u8 = null,

    /// The name of the country.
    country_name: ?[]const u8 = null,

    /// The code for the subdivision, such as a particular state within the United
    /// States. For
    /// a list of US state abbreviations, see [Appendix B: Two–Letter State and
    /// Possession Abbreviations](https://pe.usps.com/text/pub28/28apb.htm) on the
    /// United States Postal Service website. For a
    /// list of all supported subdivision codes, use the
    /// [ListGeoLocations](https://docs.aws.amazon.com/Route53/latest/APIReference/API_ListGeoLocations.html)
    /// API.
    subdivision_code: ?[]const u8 = null,

    /// The full name of the subdivision. Route 53 currently supports only states in
    /// the
    /// United States.
    subdivision_name: ?[]const u8 = null,
};
