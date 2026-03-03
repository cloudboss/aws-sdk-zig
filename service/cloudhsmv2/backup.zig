const BackupState = @import("backup_state.zig").BackupState;
const ClusterMode = @import("cluster_mode.zig").ClusterMode;
const Tag = @import("tag.zig").Tag;

/// Contains information about a backup of an CloudHSM cluster. All backup
/// objects
/// contain the `BackupId`, `BackupState`, `ClusterId`, and
/// `CreateTimestamp` parameters. Backups that were copied into a destination
/// region
/// additionally contain the `CopyTimestamp`, `SourceBackup`,
/// `SourceCluster`, and `SourceRegion` parameters. A backup that is
/// pending deletion will include the `DeleteTimestamp` parameter.
pub const Backup = struct {
    /// The Amazon Resource Name (ARN) of the backup.
    backup_arn: ?[]const u8 = null,

    /// The identifier (ID) of the backup.
    backup_id: []const u8,

    /// The state of the backup.
    backup_state: ?BackupState = null,

    /// The identifier (ID) of the cluster that was backed up.
    cluster_id: ?[]const u8 = null,

    /// The date and time when the backup was copied from a source backup.
    copy_timestamp: ?i64 = null,

    /// The date and time when the backup was created.
    create_timestamp: ?i64 = null,

    /// The date and time when the backup will be permanently deleted.
    delete_timestamp: ?i64 = null,

    /// The HSM type used to create the backup.
    hsm_type: ?[]const u8 = null,

    /// The mode of the cluster that was backed up.
    mode: ?ClusterMode = null,

    /// Specifies whether the service should exempt a backup from the retention
    /// policy for the cluster. `True` exempts
    /// a backup from the retention policy. `False` means the service applies the
    /// backup retention policy defined at the cluster.
    never_expires: ?bool = null,

    /// The identifier (ID) of the source backup from which the new backup was
    /// copied.
    source_backup: ?[]const u8 = null,

    /// The identifier (ID) of the cluster containing the source backup from which
    /// the new
    /// backup was copied.
    source_cluster: ?[]const u8 = null,

    /// The AWS Region that contains the source backup from which the new backup was
    /// copied.
    source_region: ?[]const u8 = null,

    /// The list of tags for the backup.
    tag_list: ?[]const Tag = null,

    pub const json_field_names = .{
        .backup_arn = "BackupArn",
        .backup_id = "BackupId",
        .backup_state = "BackupState",
        .cluster_id = "ClusterId",
        .copy_timestamp = "CopyTimestamp",
        .create_timestamp = "CreateTimestamp",
        .delete_timestamp = "DeleteTimestamp",
        .hsm_type = "HsmType",
        .mode = "Mode",
        .never_expires = "NeverExpires",
        .source_backup = "SourceBackup",
        .source_cluster = "SourceCluster",
        .source_region = "SourceRegion",
        .tag_list = "TagList",
    };
};
