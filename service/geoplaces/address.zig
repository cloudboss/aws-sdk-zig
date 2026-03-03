const Country = @import("country.zig").Country;
const Region = @import("region.zig").Region;
const SecondaryAddressComponent = @import("secondary_address_component.zig").SecondaryAddressComponent;
const StreetComponents = @import("street_components.zig").StreetComponents;
const SubRegion = @import("sub_region.zig").SubRegion;

/// The place address.
pub const Address = struct {
    /// The number that identifies an address within a street.
    address_number: ?[]const u8 = null,

    /// Name of the block.
    ///
    /// Example: `Sunny Mansion 203 block: 2 Chome`
    block: ?[]const u8 = null,

    /// The name of the building at the address.
    building: ?[]const u8 = null,

    /// The country component of the address.
    country: ?Country = null,

    /// The district or division of a locality associated with this address.
    district: ?[]const u8 = null,

    /// Name of the streets in the intersection.
    ///
    /// Example: `["Friedrichstraße","Unter den Linden"]`
    intersection: ?[]const []const u8 = null,

    /// Assembled address value built out of the address components, according to
    /// the regional postal rules. This is the correctly formatted address.
    label: ?[]const u8 = null,

    /// The city or locality of the address.
    ///
    /// Example: `Vancouver`.
    locality: ?[]const u8 = null,

    /// An alphanumeric string included in a postal address to facilitate mail
    /// sorting, such as post code, postcode, or ZIP code, for which the result
    /// should possess.
    postal_code: ?[]const u8 = null,

    /// The region or state results should be present in.
    ///
    /// Example: `North Rhine-Westphalia`.
    region: ?Region = null,

    /// Components that correspond to secondary identifiers on an Address. Secondary
    /// address components include information such as Suite or Unit Number,
    /// Building, or Floor.
    ///
    /// Coverage for `Address.SecondaryAddressComponents` is available in the
    /// following countries:
    ///
    /// AUS, CAN, NZL, USA, PRI
    secondary_address_components: ?[]const SecondaryAddressComponent = null,

    /// The name of the street results should be present in.
    street: ?[]const u8 = null,

    /// Components of the street.
    ///
    /// Example: Younge from the "Younge street".
    street_components: ?[]const StreetComponents = null,

    /// Name of sub-block.
    ///
    /// Example: `Sunny Mansion 203 sub-block: 4`
    sub_block: ?[]const u8 = null,

    /// A subdivision of a district.
    ///
    /// Example: `Minden-Lübbecke`.
    sub_district: ?[]const u8 = null,

    /// The sub-region or county for which results should be present in.
    sub_region: ?SubRegion = null,

    pub const json_field_names = .{
        .address_number = "AddressNumber",
        .block = "Block",
        .building = "Building",
        .country = "Country",
        .district = "District",
        .intersection = "Intersection",
        .label = "Label",
        .locality = "Locality",
        .postal_code = "PostalCode",
        .region = "Region",
        .secondary_address_components = "SecondaryAddressComponents",
        .street = "Street",
        .street_components = "StreetComponents",
        .sub_block = "SubBlock",
        .sub_district = "SubDistrict",
        .sub_region = "SubRegion",
    };
};
