const Tag = @import("tag.zig").Tag;
const DeleteFileSystemOpenZFSOption = @import("delete_file_system_open_zfs_option.zig").DeleteFileSystemOpenZFSOption;

/// The configuration object for the Amazon FSx for OpenZFS file system used in
/// the
/// `DeleteFileSystem` operation.
pub const DeleteFileSystemOpenZFSConfiguration = struct {
    /// A list of tags to apply to the file system's final backup.
    final_backup_tags: ?[]const Tag = null,

    /// To delete a file system if there are child volumes present below the root
    /// volume,
    /// use the string `DELETE_CHILD_VOLUMES_AND_SNAPSHOTS`. If your file system
    /// has child volumes and you don't use this option, the delete request will
    /// fail.
    options: ?[]const DeleteFileSystemOpenZFSOption = null,

    /// By default, Amazon FSx for OpenZFS takes a final backup on your behalf when
    /// the `DeleteFileSystem` operation is invoked. Doing this helps protect you
    /// from data loss, and we highly recommend taking the final backup. If you want
    /// to skip
    /// taking a final backup, set this value to `true`.
    skip_final_backup: ?bool = null,

    pub const json_field_names = .{
        .final_backup_tags = "FinalBackupTags",
        .options = "Options",
        .skip_final_backup = "SkipFinalBackup",
    };
};
