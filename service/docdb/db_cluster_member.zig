/// Contains information about an instance that is part of a cluster.
pub const DBClusterMember = struct {
    /// Specifies the status of the cluster parameter group for this member of the
    /// DB
    /// cluster.
    db_cluster_parameter_group_status: ?[]const u8,

    /// Specifies the instance identifier for this member of the cluster.
    db_instance_identifier: ?[]const u8,

    /// A value that is `true` if the cluster member is the primary instance for
    /// the cluster and `false` otherwise.
    is_cluster_writer: ?bool,

    /// A value that specifies the order in which an Amazon DocumentDB replica is
    /// promoted to the
    /// primary instance after a failure of the existing primary instance.
    promotion_tier: ?i32,
};
