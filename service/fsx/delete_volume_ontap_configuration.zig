const Tag = @import("tag.zig").Tag;

/// Use to specify skipping a final backup, adding tags to a final backup, or
/// bypassing the
/// retention period of an FSx for ONTAP SnapLock Enterprise volume when
/// deleting an
/// FSx for ONTAP volume.
pub const DeleteVolumeOntapConfiguration = struct {
    /// Setting this to `true` allows a SnapLock administrator to delete an FSx for
    /// ONTAP SnapLock Enterprise volume
    /// with unexpired write once, read many (WORM) files. The IAM permission
    /// `fsx:BypassSnaplockEnterpriseRetention` is also
    /// required to delete SnapLock Enterprise volumes with unexpired WORM files.
    /// The default value is `false`.
    ///
    /// For more information, see
    /// [
    /// Deleting a SnapLock
    /// volume](https://docs.aws.amazon.com/fsx/latest/ONTAPGuide/snaplock-delete-volume.html).
    bypass_snaplock_enterprise_retention: ?bool = null,

    final_backup_tags: ?[]const Tag = null,

    /// Set to true if you want to skip taking a final backup of the volume
    /// you are deleting.
    skip_final_backup: ?bool = null,

    pub const json_field_names = .{
        .bypass_snaplock_enterprise_retention = "BypassSnaplockEnterpriseRetention",
        .final_backup_tags = "FinalBackupTags",
        .skip_final_backup = "SkipFinalBackup",
    };
};
