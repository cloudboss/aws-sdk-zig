/// Describes a cluster security group.
pub const ClusterSecurityGroupMembership = struct {
    /// The name of the cluster security group.
    cluster_security_group_name: ?[]const u8 = null,

    /// The status of the cluster security group.
    status: ?[]const u8 = null,
};
