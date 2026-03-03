/// Describes the errors returned by a snapshot.
pub const SnapshotErrorMessage = struct {
    /// The failure code for the error.
    failure_code: ?[]const u8 = null,

    /// The text message describing the error.
    failure_reason: ?[]const u8 = null,

    /// A unique identifier for the cluster.
    snapshot_cluster_identifier: ?[]const u8 = null,

    /// A unique identifier for the snapshot returning the error.
    snapshot_identifier: ?[]const u8 = null,
};
