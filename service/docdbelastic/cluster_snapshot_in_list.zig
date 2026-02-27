const Status = @import("status.zig").Status;

/// A list of elastic cluster snapshots.
pub const ClusterSnapshotInList = struct {
    /// The ARN identifier of the elastic cluster.
    cluster_arn: []const u8,

    /// The ARN identifier of the elastic cluster snapshot.
    snapshot_arn: []const u8,

    /// The time when the elastic cluster snapshot was created in Universal
    /// Coordinated Time (UTC).
    snapshot_creation_time: []const u8,

    /// The name of the elastic cluster snapshot.
    snapshot_name: []const u8,

    /// The status of the elastic cluster snapshot.
    status: Status,

    pub const json_field_names = .{
        .cluster_arn = "clusterArn",
        .snapshot_arn = "snapshotArn",
        .snapshot_creation_time = "snapshotCreationTime",
        .snapshot_name = "snapshotName",
        .status = "status",
    };
};
