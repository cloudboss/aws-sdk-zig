const ReverseGeocodeFilterPlaceType = @import("reverse_geocode_filter_place_type.zig").ReverseGeocodeFilterPlaceType;

/// The included place types.
pub const ReverseGeocodeFilter = struct {
    /// The included place types. For
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers, `ap-southeast-1` and `ap-southeast-5` regions support only `Street` and `PointAddress` values.
    include_place_types: ?[]const ReverseGeocodeFilterPlaceType = null,

    pub const json_field_names = .{
        .include_place_types = "IncludePlaceTypes",
    };
};
