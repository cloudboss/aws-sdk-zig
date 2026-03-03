const AttachedDisk = @import("attached_disk.zig").AttachedDisk;
const AutoSnapshotStatus = @import("auto_snapshot_status.zig").AutoSnapshotStatus;

/// Describes an automatic snapshot.
pub const AutoSnapshotDetails = struct {
    /// The timestamp when the automatic snapshot was created.
    created_at: ?i64 = null,

    /// The date of the automatic snapshot in `YYYY-MM-DD` format.
    date: ?[]const u8 = null,

    /// An array of objects that describe the block storage disks attached to the
    /// instance when
    /// the automatic snapshot was created.
    from_attached_disks: ?[]const AttachedDisk = null,

    /// The status of the automatic snapshot.
    status: ?AutoSnapshotStatus = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .date = "date",
        .from_attached_disks = "fromAttachedDisks",
        .status = "status",
    };
};
