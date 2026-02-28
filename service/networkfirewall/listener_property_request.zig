const ListenerPropertyType = @import("listener_property_type.zig").ListenerPropertyType;

/// This data type is used specifically for the CreateProxy and
/// UpdateProxy APIs.
///
/// Open port for taking HTTP or HTTPS traffic.
pub const ListenerPropertyRequest = struct {
    /// Port for processing traffic.
    port: i32,

    /// Selection of HTTP or HTTPS traffic.
    @"type": ListenerPropertyType,

    pub const json_field_names = .{
        .port = "Port",
        .@"type" = "Type",
    };
};
