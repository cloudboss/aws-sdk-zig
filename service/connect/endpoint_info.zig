const EndpointType = @import("endpoint_type.zig").EndpointType;

/// Information about the endpoint.
pub const EndpointInfo = struct {
    /// Address of the endpoint.
    address: ?[]const u8,

    /// Display name of the endpoint.
    display_name: ?[]const u8,

    /// Type of endpoint.
    type: ?EndpointType,

    pub const json_field_names = .{
        .address = "Address",
        .display_name = "DisplayName",
        .type = "Type",
    };
};
