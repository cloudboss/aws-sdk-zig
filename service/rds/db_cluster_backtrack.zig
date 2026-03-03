/// This data type is used as a response element in the
/// `DescribeDBClusterBacktracks` action.
pub const DBClusterBacktrack = struct {
    /// The timestamp of the time from which the DB cluster was backtracked.
    backtracked_from: ?i64 = null,

    /// Contains the backtrack identifier.
    backtrack_identifier: ?[]const u8 = null,

    /// The timestamp of the time at which the backtrack was requested.
    backtrack_request_creation_time: ?i64 = null,

    /// The timestamp of the time to which the DB cluster was backtracked.
    backtrack_to: ?i64 = null,

    /// Contains a user-supplied DB cluster identifier. This identifier is the
    /// unique key that identifies a DB cluster.
    db_cluster_identifier: ?[]const u8 = null,

    /// The status of the backtrack. This property returns one of the following
    /// values:
    ///
    /// * `applying` - The backtrack is currently being applied to or rolled back
    ///   from the DB cluster.
    /// * `completed` - The backtrack has successfully been applied to or rolled
    ///   back from the DB cluster.
    /// * `failed` - An error occurred while the backtrack was applied to or rolled
    ///   back from the DB cluster.
    /// * `pending` - The backtrack is currently pending application to or rollback
    ///   from the DB cluster.
    status: ?[]const u8 = null,
};
