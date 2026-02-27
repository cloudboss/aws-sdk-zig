/// Provides details about the Amazon SNS event notifications for the specified
/// backup vault.
pub const AwsBackupBackupVaultNotificationsDetails = struct {
    /// An array of events that indicate the status of jobs to back up resources to
    /// the backup vault.
    /// The following events are supported:
    ///
    /// * `BACKUP_JOB_STARTED | BACKUP_JOB_COMPLETED`
    ///
    /// * `COPY_JOB_STARTED | COPY_JOB_SUCCESSFUL | COPY_JOB_FAILED`
    ///
    /// * `RESTORE_JOB_STARTED | RESTORE_JOB_COMPLETED | RECOVERY_POINT_MODIFIED`
    ///
    /// * `S3_BACKUP_OBJECT_FAILED | S3_RESTORE_OBJECT_FAILED`
    backup_vault_events: ?[]const []const u8,

    /// The Amazon Resource Name (ARN) that uniquely identifies the Amazon SNS topic
    /// for
    /// a backup vault's events.
    sns_topic_arn: ?[]const u8,

    pub const json_field_names = .{
        .backup_vault_events = "BackupVaultEvents",
        .sns_topic_arn = "SnsTopicArn",
    };
};
