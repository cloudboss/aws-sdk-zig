/// A security group that is associated with the cluster.
pub const AwsRedshiftClusterClusterSecurityGroup = struct {
    /// The name of the cluster security group.
    cluster_security_group_name: ?[]const u8 = null,

    /// The status of the cluster security group.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .cluster_security_group_name = "ClusterSecurityGroupName",
        .status = "Status",
    };
};
