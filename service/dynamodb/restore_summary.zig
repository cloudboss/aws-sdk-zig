/// Contains details for the restore.
pub const RestoreSummary = struct {
    /// Point in time or source backup time.
    restore_date_time: i64,

    /// Indicates if a restore is in progress or not.
    restore_in_progress: bool,

    /// The Amazon Resource Name (ARN) of the backup from which the table was
    /// restored.
    source_backup_arn: ?[]const u8,

    /// The ARN of the source table of the backup that is being restored.
    source_table_arn: ?[]const u8,
};
