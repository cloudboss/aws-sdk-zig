const GeocodeParsedQueryAddressComponents = @import("geocode_parsed_query_address_components.zig").GeocodeParsedQueryAddressComponents;
const ParsedQueryComponent = @import("parsed_query_component.zig").ParsedQueryComponent;

/// Parsed components in the provided QueryText.
pub const GeocodeParsedQuery = struct {
    /// The place address.
    address: ?GeocodeParsedQueryAddressComponents = null,

    /// The localized display name of this result item based on request parameter
    /// `language`.
    title: ?[]const ParsedQueryComponent = null,

    pub const json_field_names = .{
        .address = "Address",
        .title = "Title",
    };
};
