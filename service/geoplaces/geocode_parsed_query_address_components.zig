const ParsedQueryComponent = @import("parsed_query_component.zig").ParsedQueryComponent;
const ParsedQuerySecondaryAddressComponent = @import("parsed_query_secondary_address_component.zig").ParsedQuerySecondaryAddressComponent;

/// Parsed address components in the provided QueryText.
pub const GeocodeParsedQueryAddressComponents = struct {
    /// The number that identifies an address within a street.
    address_number: ?[]const ParsedQueryComponent,

    /// Name of the block.
    ///
    /// Example: `Sunny Mansion 203 block: 2 Chome`
    block: ?[]const ParsedQueryComponent,

    /// The name of the building at the address.
    building: ?[]const ParsedQueryComponent,

    /// The alpha-2 or alpha-3 character code for the country that the results will
    /// be present in.
    country: ?[]const ParsedQueryComponent,

    /// The district or division of a city the results should be present in.
    district: ?[]const ParsedQueryComponent,

    /// The city or locality of the address.
    ///
    /// Example: `Vancouver`.
    locality: ?[]const ParsedQueryComponent,

    /// An alphanumeric string included in a postal address to facilitate mail
    /// sorting, such as post code, postcode, or ZIP code, for which the result
    /// should possess.
    postal_code: ?[]const ParsedQueryComponent,

    /// The region or state results should be present in.
    ///
    /// Example: `North Rhine-Westphalia`.
    region: ?[]const ParsedQueryComponent,

    /// Parsed secondary address components from the provided query text.
    ///
    /// Coverage for `ParsedQuery.Address.SecondaryAddressComponents` is available
    /// in the following countries:
    ///
    /// AUS, AUT, BRA, CAN, ESP, FRA, GBR, HKG, IDN, IND, NZL, TUR, TWN, USA
    secondary_address_components: ?[]const ParsedQuerySecondaryAddressComponent,

    /// The name of the street results should be present in.
    street: ?[]const ParsedQueryComponent,

    /// Name of sub-block.
    ///
    /// Example: `Sunny Mansion 203 sub-block: 4`
    sub_block: ?[]const ParsedQueryComponent,

    /// A subdivision of a district.
    ///
    /// Example: `Minden-Lübbecke`.
    sub_district: ?[]const ParsedQueryComponent,

    /// The sub-region or county for which results should be present in.
    sub_region: ?[]const ParsedQueryComponent,

    pub const json_field_names = .{
        .address_number = "AddressNumber",
        .block = "Block",
        .building = "Building",
        .country = "Country",
        .district = "District",
        .locality = "Locality",
        .postal_code = "PostalCode",
        .region = "Region",
        .secondary_address_components = "SecondaryAddressComponents",
        .street = "Street",
        .sub_block = "SubBlock",
        .sub_district = "SubDistrict",
        .sub_region = "SubRegion",
    };
};
