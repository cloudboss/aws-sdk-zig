const EndpointType = @import("endpoint_type.zig").EndpointType;

/// Information about the endpoint.
pub const Endpoint = struct {
    /// Address of the endpoint.
    address: ?[]const u8 = null,

    /// Type of the endpoint.
    @"type": ?EndpointType = null,

    pub const json_field_names = .{
        .address = "Address",
        .@"type" = "Type",
    };
};
