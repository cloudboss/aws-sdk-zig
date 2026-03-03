const SSEType = @import("sse_type.zig").SSEType;
const SSEStatus = @import("sse_status.zig").SSEStatus;

/// The description of the server-side encryption status on the specified table.
pub const SSEDescription = struct {
    /// Indicates the time, in UNIX epoch date format, when DynamoDB detected that
    /// the table's KMS key was inaccessible. This attribute will automatically
    /// be cleared when DynamoDB detects that the table's KMS key is accessible
    /// again. DynamoDB will initiate the table archival process when table's KMS
    /// key remains inaccessible for more than seven days from this date.
    inaccessible_encryption_date_time: ?i64 = null,

    /// The KMS key ARN used for the KMS encryption.
    kms_master_key_arn: ?[]const u8 = null,

    /// Server-side encryption type. The only supported value is:
    ///
    /// * `KMS` - Server-side encryption that uses Key Management Service. The
    /// key is stored in your account and is managed by KMS (KMS charges apply).
    sse_type: ?SSEType = null,

    /// Represents the current state of server-side encryption. The only supported
    /// values
    /// are:
    ///
    /// * `ENABLED` - Server-side encryption is enabled.
    ///
    /// * `UPDATING` - Server-side encryption is being updated.
    status: ?SSEStatus = null,

    pub const json_field_names = .{
        .inaccessible_encryption_date_time = "InaccessibleEncryptionDateTime",
        .kms_master_key_arn = "KMSMasterKeyArn",
        .sse_type = "SSEType",
        .status = "Status",
    };
};
