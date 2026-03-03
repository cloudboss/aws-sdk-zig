/// Contains information about the backup that will be copied and created by the
/// CopyBackupToRegion operation.
pub const DestinationBackup = struct {
    /// The date and time when both the source backup was created.
    create_timestamp: ?i64 = null,

    /// The identifier (ID) of the source backup from which the new backup was
    /// copied.
    source_backup: ?[]const u8 = null,

    /// The identifier (ID) of the cluster containing the source backup from which
    /// the new backup was copied.
    source_cluster: ?[]const u8 = null,

    /// The AWS region that contains the source backup from which the new backup was
    /// copied.
    source_region: ?[]const u8 = null,

    pub const json_field_names = .{
        .create_timestamp = "CreateTimestamp",
        .source_backup = "SourceBackup",
        .source_cluster = "SourceCluster",
        .source_region = "SourceRegion",
    };
};
