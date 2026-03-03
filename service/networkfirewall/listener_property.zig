const ListenerPropertyType = @import("listener_property_type.zig").ListenerPropertyType;

/// Open port for taking HTTP or HTTPS traffic.
pub const ListenerProperty = struct {
    /// Port for processing traffic.
    port: ?i32 = null,

    /// Selection of HTTP or HTTPS traffic.
    @"type": ?ListenerPropertyType = null,

    pub const json_field_names = .{
        .port = "Port",
        .@"type" = "Type",
    };
};
