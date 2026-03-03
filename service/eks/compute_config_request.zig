/// Request to update the configuration of the compute capability of your EKS
/// Auto Mode
/// cluster. For example, enable the capability. For more information, see EKS
/// Auto Mode
/// compute capability in the *Amazon EKS User Guide*.
pub const ComputeConfigRequest = struct {
    /// Request to enable or disable the compute capability on your EKS Auto Mode
    /// cluster. If
    /// the compute capability is enabled, EKS Auto Mode will create and delete EC2
    /// Managed
    /// Instances in your Amazon Web Services account.
    enabled: ?bool = null,

    /// Configuration for node pools that defines the compute resources for your EKS
    /// Auto Mode
    /// cluster. For more information, see EKS Auto Mode Node Pools in the
    /// *Amazon EKS User Guide*.
    node_pools: ?[]const []const u8 = null,

    /// The ARN of the IAM Role EKS will assign to EC2 Managed Instances in your EKS
    /// Auto
    /// Mode cluster. This value cannot be changed after the compute capability of
    /// EKS Auto Mode
    /// is enabled. For more information, see the IAM Reference in the
    /// *Amazon EKS User Guide*.
    node_role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .enabled = "enabled",
        .node_pools = "nodePools",
        .node_role_arn = "nodeRoleArn",
    };
};
