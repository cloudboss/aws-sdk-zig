/// The configuration of your VPC and the associated VPC endpoint. The VPC
/// endpoint is an Amazon Web Services PrivateLink resource that allows access
/// to your App Runner
/// services from within an Amazon VPC.
pub const IngressVpcConfiguration = struct {
    /// The ID of the VPC endpoint that your App Runner service connects to.
    vpc_endpoint_id: ?[]const u8,

    /// The ID of the VPC that is used for the VPC endpoint.
    vpc_id: ?[]const u8,

    pub const json_field_names = .{
        .vpc_endpoint_id = "VpcEndpointId",
        .vpc_id = "VpcId",
    };
};
