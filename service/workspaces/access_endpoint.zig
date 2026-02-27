const AccessEndpointType = @import("access_endpoint_type.zig").AccessEndpointType;

/// Describes the access type and endpoint for a WorkSpace.
pub const AccessEndpoint = struct {
    /// Indicates the type of access endpoint.
    access_endpoint_type: ?AccessEndpointType,

    /// Indicates the VPC endpoint to use for access.
    vpc_endpoint_id: ?[]const u8,

    pub const json_field_names = .{
        .access_endpoint_type = "AccessEndpointType",
        .vpc_endpoint_id = "VpcEndpointId",
    };
};
