/// Contains the partner's headquarters location using International
/// Organization for Standardization (ISO) 3166 country and subdivision codes.
pub const Headquarters = struct {
    /// The ISO 3166-1 alpha-2 country code of the partner's headquarters. For
    /// example, `US`, `BR`, or `DE`.
    country_code: []const u8,

    /// The subdivision portion of the ISO 3166-2 code for the partner's
    /// headquarters (for example, `SP` from `BR-SP`, `NSW` from `AU-NSW`, or `13`
    /// from `JP-13`).
    subdivision_code: []const u8,

    pub const json_field_names = .{
        .country_code = "CountryCode",
        .subdivision_code = "SubdivisionCode",
    };
};
