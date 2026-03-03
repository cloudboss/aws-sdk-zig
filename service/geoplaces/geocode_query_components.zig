/// A structured free text query allows you to search for places by the name or
/// text representation of specific properties of the place.
pub const GeocodeQueryComponents = struct {
    /// The house number or address results should have.
    address_number: ?[]const u8 = null,

    /// The alpha-2 or alpha-3 character code for the country that the results will
    /// be present in.
    country: ?[]const u8 = null,

    /// The district or division of a city the results should be present in.
    district: ?[]const u8 = null,

    /// The city or locality results should be present in.
    ///
    /// Example: `Vancouver`.
    locality: ?[]const u8 = null,

    /// An alphanumeric string included in a postal address to facilitate mail
    /// sorting, such as post code, postcode, or ZIP code for which the result
    /// should possess.
    postal_code: ?[]const u8 = null,

    /// The region or state results should be to be present in.
    ///
    /// Example: `North Rhine-Westphalia`.
    region: ?[]const u8 = null,

    /// The name of the street results should be present in.
    street: ?[]const u8 = null,

    /// The sub-region or county for which results should be present in.
    sub_region: ?[]const u8 = null,

    pub const json_field_names = .{
        .address_number = "AddressNumber",
        .country = "Country",
        .district = "District",
        .locality = "Locality",
        .postal_code = "PostalCode",
        .region = "Region",
        .street = "Street",
        .sub_region = "SubRegion",
    };
};
