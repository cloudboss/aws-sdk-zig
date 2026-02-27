/// Information about an option group membership for a DB cluster.
pub const AwsRdsDbClusterOptionGroupMembership = struct {
    /// The name of the DB cluster option group.
    db_cluster_option_group_name: ?[]const u8,

    /// The status of the DB cluster option group.
    status: ?[]const u8,

    pub const json_field_names = .{
        .db_cluster_option_group_name = "DbClusterOptionGroupName",
        .status = "Status",
    };
};
