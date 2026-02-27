/// Contains information about an instance that is part of a DB cluster.
pub const DBClusterMember = struct {
    /// Specifies the status of the DB cluster parameter group for this member of
    /// the DB cluster.
    db_cluster_parameter_group_status: ?[]const u8,

    /// Specifies the instance identifier for this member of the DB cluster.
    db_instance_identifier: ?[]const u8,

    /// Indicates whether the cluster member is the primary DB instance for the DB
    /// cluster.
    is_cluster_writer: ?bool,

    /// A value that specifies the order in which an Aurora Replica is promoted to
    /// the primary instance after a failure of the existing primary instance. For
    /// more information, see [ Fault Tolerance for an Aurora DB
    /// Cluster](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Aurora.Managing.Backups.html#Aurora.Managing.FaultTolerance) in the *Amazon Aurora User Guide*.
    promotion_tier: ?i32,
};
