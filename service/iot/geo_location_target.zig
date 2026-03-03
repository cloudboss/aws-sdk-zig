const TargetFieldOrder = @import("target_field_order.zig").TargetFieldOrder;

/// A geolocation target that you select to index. Each geolocation target
/// contains a
/// `name` and `order` key-value pair that specifies the geolocation
/// target fields.
pub const GeoLocationTarget = struct {
    /// The `name` of the geolocation target field. If the target field is part of a
    /// named shadow, you must select the named shadow using the `namedShadow`
    /// filter.
    name: ?[]const u8 = null,

    /// The `order` of the geolocation target field. This field is optional. The
    /// default value is `LatLon`.
    order: ?TargetFieldOrder = null,

    pub const json_field_names = .{
        .name = "name",
        .order = "order",
    };
};
