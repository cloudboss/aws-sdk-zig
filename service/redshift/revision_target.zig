/// Describes a `RevisionTarget`.
pub const RevisionTarget = struct {
    /// A unique string that identifies the version to update the cluster to. You
    /// can use this
    /// value in ModifyClusterDbRevision.
    database_revision: ?[]const u8,

    /// The date on which the database revision was released.
    database_revision_release_date: ?i64,

    /// A string that describes the changes and features that will be applied to the
    /// cluster
    /// when it is updated to the corresponding ClusterDbRevision.
    description: ?[]const u8,
};
