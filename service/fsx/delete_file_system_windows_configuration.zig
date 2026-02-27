const Tag = @import("tag.zig").Tag;

/// The configuration object for the Microsoft Windows file system used in the
/// `DeleteFileSystem` operation.
pub const DeleteFileSystemWindowsConfiguration = struct {
    /// A set of tags for your final backup.
    final_backup_tags: ?[]const Tag,

    /// By default, Amazon FSx for Windows takes a final backup on your behalf when
    /// the
    /// `DeleteFileSystem` operation is invoked. Doing this helps protect you
    /// from data loss, and we highly recommend taking the final backup. If you want
    /// to skip
    /// this backup, use this flag to do so.
    skip_final_backup: ?bool,

    pub const json_field_names = .{
        .final_backup_tags = "FinalBackupTags",
        .skip_final_backup = "SkipFinalBackup",
    };
};
