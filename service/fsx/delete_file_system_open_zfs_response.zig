const Tag = @import("tag.zig").Tag;

/// The response object for the Amazon FSx for OpenZFS file system that's being
/// deleted in the `DeleteFileSystem` operation.
pub const DeleteFileSystemOpenZFSResponse = struct {
    final_backup_id: ?[]const u8,

    final_backup_tags: ?[]const Tag,

    pub const json_field_names = .{
        .final_backup_id = "FinalBackupId",
        .final_backup_tags = "FinalBackupTags",
    };
};
