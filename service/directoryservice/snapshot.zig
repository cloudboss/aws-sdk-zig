const SnapshotStatus = @import("snapshot_status.zig").SnapshotStatus;
const SnapshotType = @import("snapshot_type.zig").SnapshotType;

/// Describes a directory snapshot.
pub const Snapshot = struct {
    /// The directory identifier.
    directory_id: ?[]const u8,

    /// The descriptive name of the snapshot.
    name: ?[]const u8,

    /// The snapshot identifier.
    snapshot_id: ?[]const u8,

    /// The date and time that the snapshot was taken.
    start_time: ?i64,

    /// The snapshot status.
    status: ?SnapshotStatus,

    /// The snapshot type.
    @"type": ?SnapshotType,

    pub const json_field_names = .{
        .directory_id = "DirectoryId",
        .name = "Name",
        .snapshot_id = "SnapshotId",
        .start_time = "StartTime",
        .status = "Status",
        .@"type" = "Type",
    };
};
