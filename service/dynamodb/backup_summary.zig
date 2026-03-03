const BackupStatus = @import("backup_status.zig").BackupStatus;
const BackupType = @import("backup_type.zig").BackupType;

/// Contains details for the backup.
pub const BackupSummary = struct {
    /// ARN associated with the backup.
    backup_arn: ?[]const u8 = null,

    /// Time at which the backup was created.
    backup_creation_date_time: ?i64 = null,

    /// Time at which the automatic on-demand backup created by DynamoDB will
    /// expire. This `SYSTEM` on-demand backup expires automatically 35 days after
    /// its creation.
    backup_expiry_date_time: ?i64 = null,

    /// Name of the specified backup.
    backup_name: ?[]const u8 = null,

    /// Size of the backup in bytes.
    backup_size_bytes: ?i64 = null,

    /// Backup can be in one of the following states: CREATING, ACTIVE, DELETED.
    backup_status: ?BackupStatus = null,

    /// BackupType:
    ///
    /// * `USER` - You create and manage these using the on-demand backup
    /// feature.
    ///
    /// * `SYSTEM` - If you delete a table with point-in-time recovery enabled,
    /// a `SYSTEM` backup is automatically created and is retained for 35
    /// days (at no additional cost). System backups allow you to restore the
    /// deleted
    /// table to the state it was in just before the point of deletion.
    ///
    /// * `AWS_BACKUP` - On-demand backup created by you from Backup service.
    backup_type: ?BackupType = null,

    /// ARN associated with the table.
    table_arn: ?[]const u8 = null,

    /// Unique identifier for the table.
    table_id: ?[]const u8 = null,

    /// Name of the table.
    table_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .backup_arn = "BackupArn",
        .backup_creation_date_time = "BackupCreationDateTime",
        .backup_expiry_date_time = "BackupExpiryDateTime",
        .backup_name = "BackupName",
        .backup_size_bytes = "BackupSizeBytes",
        .backup_status = "BackupStatus",
        .backup_type = "BackupType",
        .table_arn = "TableArn",
        .table_id = "TableId",
        .table_name = "TableName",
    };
};
