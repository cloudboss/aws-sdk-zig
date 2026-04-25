/// Information about the restore for the table.
pub const AwsDynamoDbTableRestoreSummary = struct {
    /// Indicates the point in time that the table was restored to.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub CSPM, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    restore_date_time: ?[]const u8 = null,

    /// Whether a restore is currently in progress.
    restore_in_progress: ?bool = null,

    /// The ARN of the source backup from which the table was restored.
    source_backup_arn: ?[]const u8 = null,

    /// The ARN of the source table for the backup.
    source_table_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .restore_date_time = "RestoreDateTime",
        .restore_in_progress = "RestoreInProgress",
        .source_backup_arn = "SourceBackupArn",
        .source_table_arn = "SourceTableArn",
    };
};
