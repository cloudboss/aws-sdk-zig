const SnapshotTaskDetail = @import("snapshot_task_detail.zig").SnapshotTaskDetail;
const Tag = @import("tag.zig").Tag;

/// Describes an import snapshot task.
pub const ImportSnapshotTask = struct {
    /// A description of the import snapshot task.
    description: ?[]const u8 = null,

    /// The ID of the import snapshot task.
    import_task_id: ?[]const u8 = null,

    /// Describes an import snapshot task.
    snapshot_task_detail: ?SnapshotTaskDetail = null,

    /// The tags for the import snapshot task.
    tags: ?[]const Tag = null,
};
