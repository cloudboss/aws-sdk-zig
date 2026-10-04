const AccessPointType = @import("access_point_type.zig").AccessPointType;

/// Position of the access point represented by longitude and latitude for a
/// vehicle.
pub const AccessPoint = struct {
    /// A short textual description of the access point, such as `"North Entrance"`.
    label: ?[]const u8 = null,

    /// The position in World Geodetic System (WGS 84) format: [longitude,
    /// latitude].
    position: ?[]const f64 = null,

    /// Set to `true` for the primary access position when the place has more than
    /// one access point.
    primary: ?bool = null,

    /// The type of access point, indicating its intended use. Only applies to
    /// results of type place.
    @"type": ?AccessPointType = null,

    pub const json_field_names = .{
        .label = "Label",
        .position = "Position",
        .primary = "Primary",
        .@"type" = "Type",
    };
};
