const GeocodeFilterPlaceType = @import("geocode_filter_place_type.zig").GeocodeFilterPlaceType;

/// Geocode structure which contains a set of inclusion/exclusion properties
/// that results must possess in order to be returned as a result.
pub const GeocodeFilter = struct {
    /// A list of countries that all results must be in. Countries are represented
    /// by either their alpha-2 or alpha-3 character codes.
    include_countries: ?[]const []const u8,

    /// The included place types.
    include_place_types: ?[]const GeocodeFilterPlaceType,

    pub const json_field_names = .{
        .include_countries = "IncludeCountries",
        .include_place_types = "IncludePlaceTypes",
    };
};
