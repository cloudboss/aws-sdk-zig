/// Configuration for backing up centralized log data to a secondary region.
pub const LogsBackupConfiguration = struct {
    /// KMS Key ARN belonging to the primary destination account and backup region,
    /// to encrypt newly created central log groups in the backup destination.
    kms_key_arn: ?[]const u8 = null,

    /// Logs specific backup destination region within the primary destination
    /// account to which log data should be centralized.
    region: []const u8,

    pub const json_field_names = .{
        .kms_key_arn = "KmsKeyArn",
        .region = "Region",
    };
};
