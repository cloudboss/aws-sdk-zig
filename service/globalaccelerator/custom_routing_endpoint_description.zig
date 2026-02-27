/// A complex type for an endpoint for a custom routing accelerator. Each
/// endpoint group can include one or more endpoints,
/// which are virtual private cloud (VPC) subnets.
pub const CustomRoutingEndpointDescription = struct {
    /// An ID for the endpoint. For custom routing accelerators, this is the virtual
    /// private cloud (VPC)
    /// subnet ID.
    endpoint_id: ?[]const u8,

    pub const json_field_names = .{
        .endpoint_id = "EndpointId",
    };
};
