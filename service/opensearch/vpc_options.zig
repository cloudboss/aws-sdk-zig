/// Options to specify the subnets and security groups for an Amazon OpenSearch
/// Service
/// VPC endpoint. For more information, see [Launching your Amazon
/// OpenSearch Service domains using a
/// VPC](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/vpc.html).
pub const VPCOptions = struct {
    /// Controls whether egress traffic from the domain is routed through the
    /// customer VPC.
    /// When `true`, outbound traffic flows through the VPC. When
    /// `false`, outbound traffic goes through the public internet.
    egress_enabled: ?bool = null,

    /// The list of security group IDs associated with the VPC endpoints for the
    /// domain. If
    /// you do not provide a security group ID, OpenSearch Service uses the default
    /// security
    /// group for the VPC.
    security_group_ids: ?[]const []const u8 = null,

    /// A list of subnet IDs associated with the VPC endpoints for the domain. If
    /// your domain uses
    /// multiple Availability Zones, you need to provide two subnet IDs, one per
    /// zone. Otherwise, provide
    /// only one.
    subnet_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .egress_enabled = "EgressEnabled",
        .security_group_ids = "SecurityGroupIds",
        .subnet_ids = "SubnetIds",
    };
};
