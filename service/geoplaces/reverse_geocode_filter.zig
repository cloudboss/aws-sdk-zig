const ReverseGeocodeFilterPlaceType = @import("reverse_geocode_filter_place_type.zig").ReverseGeocodeFilterPlaceType;

/// The included place types.
pub const ReverseGeocodeFilter = struct {
    /// The included place types.
    include_place_types: ?[]const ReverseGeocodeFilterPlaceType,

    pub const json_field_names = .{
        .include_place_types = "IncludePlaceTypes",
    };
};
