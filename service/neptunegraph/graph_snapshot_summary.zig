const SnapshotStatus = @import("snapshot_status.zig").SnapshotStatus;

/// Details about a graph snapshot.
pub const GraphSnapshotSummary = struct {
    /// The ARN of the graph snapshot.
    arn: []const u8,

    /// The unique identifier of the graph snapshot.
    id: []const u8,

    /// The ID of the KMS key used to encrypt and decrypt the snapshot.
    kms_key_identifier: ?[]const u8 = null,

    /// The snapshot name. For example: `my-snapshot-1`.
    ///
    /// The name must contain from 1 to 63 letters, numbers, or hyphens, and its
    /// first character must be a letter. It cannot end with a hyphen or contain two
    /// consecutive hyphens. Only lowercase letters are allowed.
    name: []const u8,

    /// The time when the snapshot was created.
    snapshot_create_time: ?i64 = null,

    /// The graph identifier for the graph for which a snapshot is to be created.
    source_graph_id: ?[]const u8 = null,

    /// The status of the graph snapshot.
    status: ?SnapshotStatus = null,

    pub const json_field_names = .{
        .arn = "arn",
        .id = "id",
        .kms_key_identifier = "kmsKeyIdentifier",
        .name = "name",
        .snapshot_create_time = "snapshotCreateTime",
        .source_graph_id = "sourceGraphId",
        .status = "status",
    };
};
