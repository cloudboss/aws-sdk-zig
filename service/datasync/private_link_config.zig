/// Specifies how your DataSync agent connects to Amazon Web Services using a
/// [virtual private cloud (VPC) service
/// endpoint](https://docs.aws.amazon.com/datasync/latest/userguide/choose-service-endpoint.html#choose-service-endpoint-vpc). An agent that uses a VPC endpoint
/// isn't accessible over the public internet.
pub const PrivateLinkConfig = struct {
    /// Specifies the VPC endpoint provided by [Amazon Web Services
    /// PrivateLink](https://docs.aws.amazon.com/vpc/latest/privatelink/privatelink-share-your-services.html) that your agent connects to.
    private_link_endpoint: ?[]const u8,

    /// Specifies the Amazon Resource Names (ARN) of the security group that
    /// provides DataSync access to your VPC endpoint. You can only specify one ARN.
    security_group_arns: ?[]const []const u8,

    /// Specifies the ARN of the subnet where your VPC endpoint is located. You can
    /// only specify
    /// one ARN.
    subnet_arns: ?[]const []const u8,

    /// Specifies the ID of the VPC endpoint that your agent connects to.
    vpc_endpoint_id: ?[]const u8,

    pub const json_field_names = .{
        .private_link_endpoint = "PrivateLinkEndpoint",
        .security_group_arns = "SecurityGroupArns",
        .subnet_arns = "SubnetArns",
        .vpc_endpoint_id = "VpcEndpointId",
    };
};
