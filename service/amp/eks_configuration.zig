/// The `EksConfiguration` structure describes the connection to the Amazon EKS
/// cluster from which a scraper collects metrics.
pub const EksConfiguration = struct {
    /// ARN of the Amazon EKS cluster.
    cluster_arn: []const u8,

    /// A list of the security group IDs for the Amazon EKS cluster VPC
    /// configuration.
    security_group_ids: ?[]const []const u8,

    /// A list of subnet IDs for the Amazon EKS cluster VPC configuration.
    subnet_ids: []const []const u8,

    pub const json_field_names = .{
        .cluster_arn = "clusterArn",
        .security_group_ids = "securityGroupIds",
        .subnet_ids = "subnetIds",
    };
};
