/// The list of endpoint objects. For custom routing, this is a list of virtual
/// private cloud (VPC) subnet IDs.
pub const CustomRoutingEndpointConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the cross-account attachment that
    /// specifies the endpoints (resources)
    /// that can be added to accelerators and principals that have permission to add
    /// the endpoints.
    attachment_arn: ?[]const u8,

    /// An ID for the endpoint. For custom routing accelerators, this is the virtual
    /// private cloud (VPC)
    /// subnet ID.
    endpoint_id: ?[]const u8,

    pub const json_field_names = .{
        .attachment_arn = "AttachmentArn",
        .endpoint_id = "EndpointId",
    };
};
