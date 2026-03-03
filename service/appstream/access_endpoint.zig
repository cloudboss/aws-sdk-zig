const AccessEndpointType = @import("access_endpoint_type.zig").AccessEndpointType;

/// Describes an interface VPC endpoint (interface endpoint) that lets you
/// create a private connection between the virtual private cloud (VPC) that you
/// specify and WorkSpaces Applications. When you specify an interface endpoint
/// for a stack, users of the stack can connect to WorkSpaces Applications only
/// through that endpoint. When you specify an interface endpoint for an image
/// builder, administrators can connect to the image builder only through that
/// endpoint.
pub const AccessEndpoint = struct {
    /// The type of interface endpoint.
    endpoint_type: AccessEndpointType,

    /// The identifier (ID) of the VPC in which the interface endpoint is used.
    vpce_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .endpoint_type = "EndpointType",
        .vpce_id = "VpceId",
    };
};
