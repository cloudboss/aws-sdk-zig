const Tag = @import("tag.zig").Tag;

/// The configuration object for the Amazon FSx for Lustre file system being
/// deleted in the
/// `DeleteFileSystem` operation.
pub const DeleteFileSystemLustreConfiguration = struct {
    /// Use if `SkipFinalBackup` is set to `false`,
    /// and you want to apply an array of tags to the final backup. If you have set
    /// the file system property
    /// `CopyTagsToBackups` to true, and
    /// you specify one or more `FinalBackupTags` when deleting a file system,
    /// Amazon FSx will not copy any existing file system tags to the backup.
    final_backup_tags: ?[]const Tag = null,

    /// Set `SkipFinalBackup` to false if you want to take a final backup of the
    /// file
    /// system you are deleting. By default, Amazon FSx will not take a final backup
    /// on your behalf when the
    /// `DeleteFileSystem` operation is invoked. (Default = true)
    ///
    /// The `fsx:CreateBackup` permission is required if you set `SkipFinalBackup`
    /// to `false` in order to delete the file system and take a final backup.
    skip_final_backup: ?bool = null,

    pub const json_field_names = .{
        .final_backup_tags = "FinalBackupTags",
        .skip_final_backup = "SkipFinalBackup",
    };
};
