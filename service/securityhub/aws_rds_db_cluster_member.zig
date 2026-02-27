/// Information about an instance in the DB cluster.
pub const AwsRdsDbClusterMember = struct {
    /// The status of the DB cluster parameter group for this member of the DB
    /// cluster.
    db_cluster_parameter_group_status: ?[]const u8,

    /// The instance identifier for this member of the DB cluster.
    db_instance_identifier: ?[]const u8,

    /// Whether the cluster member is the primary instance for the DB cluster.
    is_cluster_writer: ?bool,

    /// Specifies the order in which an Aurora replica is promoted to the primary
    /// instance when
    /// the existing primary instance fails.
    promotion_tier: ?i32,

    pub const json_field_names = .{
        .db_cluster_parameter_group_status = "DbClusterParameterGroupStatus",
        .db_instance_identifier = "DbInstanceIdentifier",
        .is_cluster_writer = "IsClusterWriter",
        .promotion_tier = "PromotionTier",
    };
};
