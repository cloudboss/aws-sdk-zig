const EndpointType = @import("endpoint_type.zig").EndpointType;

/// Information about the endpoint.
pub const Endpoint = struct {
    /// Address of the endpoint.
    address: ?[]const u8,

    /// Type of the endpoint.
    @"type": ?EndpointType,

    pub const json_field_names = .{
        .address = "Address",
        .@"type" = "Type",
    };
};
