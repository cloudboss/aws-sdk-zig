const SnapshotFile = @import("snapshot_file.zig").SnapshotFile;

/// A structure that contains the information on the snapshot files.
pub const SnapshotFileGroup = struct {
    /// A list of `SnapshotFile` objects that contain the information on the
    /// snapshot files that need to be generated. This structure can hold 1
    /// configuration at a time.
    files: ?[]const SnapshotFile = null,

    pub const json_field_names = .{
        .files = "Files",
    };
};
