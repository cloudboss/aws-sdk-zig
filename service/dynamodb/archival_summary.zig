/// Contains details of a table archival operation.
pub const ArchivalSummary = struct {
    /// The Amazon Resource Name (ARN) of the backup the table was archived to, when
    /// applicable in the archival reason. If you wish to restore this backup to the
    /// same table
    /// name, you will need to delete the original table.
    archival_backup_arn: ?[]const u8 = null,

    /// The date and time when table archival was initiated by DynamoDB, in UNIX
    /// epoch time
    /// format.
    archival_date_time: ?i64 = null,

    /// The reason DynamoDB archived the table. Currently, the only possible value
    /// is:
    ///
    /// * `INACCESSIBLE_ENCRYPTION_CREDENTIALS` - The table was archived due
    /// to the table's KMS key being inaccessible for more than seven
    /// days. An On-Demand backup was created at the archival time.
    archival_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .archival_backup_arn = "ArchivalBackupArn",
        .archival_date_time = "ArchivalDateTime",
        .archival_reason = "ArchivalReason",
    };
};
