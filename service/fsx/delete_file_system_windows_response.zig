const Tag = @import("tag.zig").Tag;

/// The response object for the Microsoft Windows file system used in the
/// `DeleteFileSystem` operation.
pub const DeleteFileSystemWindowsResponse = struct {
    /// The ID of the final backup for this file system.
    final_backup_id: ?[]const u8 = null,

    /// The set of tags applied to the final backup.
    final_backup_tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .final_backup_id = "FinalBackupId",
        .final_backup_tags = "FinalBackupTags",
    };
};
