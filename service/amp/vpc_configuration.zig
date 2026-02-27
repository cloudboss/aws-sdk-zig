/// The Amazon VPC configuration that specifies the network settings for a
/// Prometheus collector to securely connect to Amazon MSK clusters. This
/// configuration includes the security groups and subnets that control network
/// access and placement for the collector.
pub const VpcConfiguration = struct {
    /// The security group IDs that control network access for the Prometheus
    /// collector. These security groups must allow the collector to communicate
    /// with your Amazon MSK cluster on the required ports.
    security_group_ids: []const []const u8,

    /// The subnet IDs where the Prometheus collector will be deployed. The subnets
    /// must be in the same Amazon VPC as your Amazon MSK cluster and have network
    /// connectivity to the cluster.
    subnet_ids: []const []const u8,

    pub const json_field_names = .{
        .security_group_ids = "securityGroupIds",
        .subnet_ids = "subnetIds",
    };
};
