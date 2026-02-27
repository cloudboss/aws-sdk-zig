const Highlight = @import("highlight.zig").Highlight;
const CountryHighlights = @import("country_highlights.zig").CountryHighlights;
const RegionHighlights = @import("region_highlights.zig").RegionHighlights;
const SubRegionHighlights = @import("sub_region_highlights.zig").SubRegionHighlights;

/// Describes how the parts of the response element matched the input query by
/// returning the sections of the response which matched to input query terms.
pub const AutocompleteAddressHighlights = struct {
    /// The house number or address results should have.
    address_number: ?[]const Highlight,

    /// Name of the block.
    ///
    /// Example: `Sunny Mansion 203 block: 2 Chome`
    block: ?[]const Highlight,

    /// The name of the building at the address.
    building: ?[]const Highlight,

    /// The alpha-2 or alpha-3 character code for the country that the results will
    /// be present in.
    country: ?CountryHighlights,

    /// The district or division of a city the results should be present in.
    district: ?[]const Highlight,

    /// Name of the streets in the intersection. For example: e.g.
    /// ["Friedrichstraße","Unter den Linden"]
    intersection: ?[]const []const Highlight,

    /// Indicates the starting and ending indexes for result items where they are
    /// identified to match the input query. This should be used to provide emphasis
    /// to output display to make selecting the correct result from a list easier
    /// for end users.
    label: ?[]const Highlight,

    /// The city or locality results should be present in.
    ///
    /// Example: `Vancouver`.
    locality: ?[]const Highlight,

    /// An alphanumeric string included in a postal address to facilitate mail
    /// sorting, such as post code, postcode, or ZIP code for which the result
    /// should possess.
    postal_code: ?[]const Highlight,

    /// The region or state results should be to be present in.
    ///
    /// Example: `North Rhine-Westphalia`.
    region: ?RegionHighlights,

    /// The name of the street results should be present in.
    street: ?[]const Highlight,

    /// Name of sub-block.
    ///
    /// Example: `Sunny Mansion 203 sub-block: 4`
    sub_block: ?[]const Highlight,

    /// Indicates the starting and ending index of the title in the text query that
    /// match the found title.
    sub_district: ?[]const Highlight,

    /// The sub-region or county for which results should be present in.
    sub_region: ?SubRegionHighlights,

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
        .street = "Street",
        .sub_block = "SubBlock",
        .sub_district = "SubDistrict",
        .sub_region = "SubRegion",
    };
};
