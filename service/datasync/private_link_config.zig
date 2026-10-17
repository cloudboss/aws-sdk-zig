/// Specifies how your DataSync agent connects to Amazon Web Services using a
/// [virtual private cloud (VPC) service
/// endpoint](https://docs.aws.amazon.com/datasync/latest/userguide/choose-service-endpoint.html#choose-service-endpoint-vpc). An agent that uses a VPC endpoint
/// isn't accessible over the public internet.
pub const PrivateLinkConfig = struct {
    /// Specifies the VPC endpoint provided by [Amazon Web Services
    /// PrivateLink](https://docs.aws.amazon.com/vpc/latest/privatelink/privatelink-share-your-services.html) that your agent connects to.
    private_link_endpoint: ?[]const u8 = null,

    /// Specifies the Amazon Resource Names (ARN) of the security group that
    /// provides DataSync access to your VPC endpoint. You can only specify one ARN.
    security_group_arns: ?[]const []const u8 = null,

    /// Specifies the ARN of the subnet where DataSync creates the network
    /// interfaces
    /// that handle data transfer traffic for your tasks. You can only specify one
    /// ARN.
    ///
    /// The subnet doesn't have to be the subnet that contains your VPC endpoint.
    subnet_arns: ?[]const []const u8 = null,

    /// Specifies the ID of the VPC service endpoint that's recorded for your agent.
    /// The endpoint ID
    /// is informational and isn't verified by DataSync. Your agent communicates
    /// through the
    /// private IP address in `PrivateLinkEndpoint`, which is set when you activate
    /// the
    /// agent.
    vpc_endpoint_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .private_link_endpoint = "PrivateLinkEndpoint",
        .security_group_arns = "SecurityGroupArns",
        .subnet_arns = "SubnetArns",
        .vpc_endpoint_id = "VpcEndpointId",
    };
};
