/// Contains status information for a DB cluster option group.
pub const DBClusterOptionGroupStatus = struct {
    /// Specifies the name of the DB cluster option group.
    db_cluster_option_group_name: ?[]const u8,

    /// Specifies the status of the DB cluster option group.
    status: ?[]const u8,
};
