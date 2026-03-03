const SnapshotStatus = @import("snapshot_status.zig").SnapshotStatus;
const SnapshotType = @import("snapshot_type.zig").SnapshotType;

/// Describes a directory snapshot.
pub const Snapshot = struct {
    /// The directory identifier.
    directory_id: ?[]const u8 = null,

    /// The descriptive name of the snapshot.
    name: ?[]const u8 = null,

    /// The snapshot identifier.
    snapshot_id: ?[]const u8 = null,

    /// The date and time that the snapshot was taken.
    start_time: ?i64 = null,

    /// The snapshot status.
    status: ?SnapshotStatus = null,

    /// The snapshot type.
    @"type": ?SnapshotType = null,

    pub const json_field_names = .{
        .directory_id = "DirectoryId",
        .name = "Name",
        .snapshot_id = "SnapshotId",
        .start_time = "StartTime",
        .status = "Status",
        .@"type" = "Type",
    };
};
