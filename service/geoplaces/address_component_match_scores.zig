const SecondaryAddressComponentMatchScore = @import("secondary_address_component_match_score.zig").SecondaryAddressComponentMatchScore;

/// Indicates how well the entire input matches the returned. It is equal to 1
/// if all input tokens are recognized and matched.
pub const AddressComponentMatchScores = struct {
    /// The house number or address results should have.
    address_number: f64 = 0,

    /// Name of the block.
    ///
    /// Example: `Sunny Mansion 203 block: 2 Chome`
    block: f64 = 0,

    /// The name of the building at the address.
    building: f64 = 0,

    /// The alpha-2 or alpha-3 character code for the country that the results will
    /// be present in.
    country: f64 = 0,

    /// The district or division of a city the results should be present in.
    district: f64 = 0,

    /// Name of the streets in the intersection.
    ///
    /// Example: `["Friedrichstraße","Unter den Linden"]`
    intersection: ?[]const f64 = null,

    /// The city or locality results should be present in.
    ///
    /// Example: `Vancouver`.
    locality: f64 = 0,

    /// An alphanumeric string included in a postal address to facilitate mail
    /// sorting, such as post code, postcode, or ZIP code, for which the result
    /// should possess.
    postal_code: f64 = 0,

    /// The region or state results should be to be present in.
    ///
    /// Example: `North Rhine-Westphalia`.
    region: f64 = 0,

    /// Match scores for the secondary address components in the result.
    ///
    /// Coverage for this functionality is available in the following countries:
    /// AUS, AUT, BRA, CAN, ESP, FRA, GBR, IDN, IND, NZL, TUR, TWN, USA.
    secondary_address_components: ?[]const SecondaryAddressComponentMatchScore = null,

    /// Name of sub-block.
    ///
    /// Example: `Sunny Mansion 203 sub-block: 4`
    sub_block: f64 = 0,

    /// A subdivision of a district.
    ///
    /// Example: `Minden-Lübbecke`
    sub_district: f64 = 0,

    /// The sub-region or county for which results should be present in.
    sub_region: f64 = 0,

    pub const json_field_names = .{
        .address_number = "AddressNumber",
        .block = "Block",
        .building = "Building",
        .country = "Country",
        .district = "District",
        .intersection = "Intersection",
        .locality = "Locality",
        .postal_code = "PostalCode",
        .region = "Region",
        .secondary_address_components = "SecondaryAddressComponents",
        .sub_block = "SubBlock",
        .sub_district = "SubDistrict",
        .sub_region = "SubRegion",
    };
};
