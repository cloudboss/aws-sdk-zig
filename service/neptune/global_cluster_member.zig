/// A data structure with information about any primary and
/// secondary clusters associated with an Neptune global database.
pub const GlobalClusterMember = struct {
    /// The Amazon Resource Name (ARN) for each Neptune cluster.
    db_cluster_arn: ?[]const u8,

    /// Specifies whether the Neptune cluster is the primary cluster
    /// (that is, has read-write capability) for the Neptune global
    /// database with which it is associated.
    is_writer: ?bool,

    /// The Amazon Resource Name (ARN) for each read-only secondary cluster
    /// associated with the Neptune global database.
    readers: ?[]const []const u8,
};
