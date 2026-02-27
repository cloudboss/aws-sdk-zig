const Tag = @import("tag.zig").Tag;

/// The response object for the Amazon FSx for Lustre file system being deleted
/// in the
/// `DeleteFileSystem` operation.
pub const DeleteFileSystemLustreResponse = struct {
    /// The ID of the final backup for this file system.
    final_backup_id: ?[]const u8,

    /// The set of tags applied to the final backup.
    final_backup_tags: ?[]const Tag,

    pub const json_field_names = .{
        .final_backup_id = "FinalBackupId",
        .final_backup_tags = "FinalBackupTags",
    };
};
