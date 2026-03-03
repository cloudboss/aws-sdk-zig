const RevisionTarget = @import("revision_target.zig").RevisionTarget;

/// Describes a `ClusterDbRevision`.
pub const ClusterDbRevision = struct {
    /// The unique identifier of the cluster.
    cluster_identifier: ?[]const u8 = null,

    /// A string representing the current cluster version.
    current_database_revision: ?[]const u8 = null,

    /// The date on which the database revision was released.
    database_revision_release_date: ?i64 = null,

    /// A list of `RevisionTarget` objects, where each object describes the
    /// database revision that a cluster can be updated to.
    revision_targets: ?[]const RevisionTarget = null,
};
