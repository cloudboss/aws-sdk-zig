/// Indicates the status of the request to update the compute capability of your
/// EKS Auto
/// Mode cluster.
pub const ComputeConfigResponse = struct {
    /// Indicates if the compute capability is enabled on your EKS Auto Mode
    /// cluster. If the
    /// compute capability is enabled, EKS Auto Mode will create and delete EC2
    /// Managed
    /// Instances in your Amazon Web Services account.
    enabled: ?bool = null,

    /// Indicates the current configuration of node pools in your EKS Auto Mode
    /// cluster. For
    /// more information, see EKS Auto Mode Node Pools in the *Amazon EKS User
    /// Guide*.
    node_pools: ?[]const []const u8 = null,

    /// The ARN of the IAM Role EKS will assign to EC2 Managed Instances in your EKS
    /// Auto
    /// Mode cluster.
    node_role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .enabled = "enabled",
        .node_pools = "nodePools",
        .node_role_arn = "nodeRoleArn",
    };
};
