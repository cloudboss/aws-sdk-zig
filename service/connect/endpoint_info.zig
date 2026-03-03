const EndpointType = @import("endpoint_type.zig").EndpointType;

/// Information about the endpoint.
pub const EndpointInfo = struct {
    /// Address of the endpoint.
    address: ?[]const u8 = null,

    /// Display name of the endpoint.
    display_name: ?[]const u8 = null,

    /// Type of endpoint.
    @"type": ?EndpointType = null,

    pub const json_field_names = .{
        .address = "Address",
        .display_name = "DisplayName",
        .@"type" = "Type",
    };
};
