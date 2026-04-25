/// Information about the server-side encryption for the table.
pub const AwsDynamoDbTableSseDescription = struct {
    /// If the key is inaccessible, the date and time when DynamoDB detected that
    /// the key was
    /// inaccessible.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub CSPM, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    inaccessible_encryption_date_time: ?[]const u8 = null,

    /// The ARN of the KMS key that is used for the KMS
    /// encryption.
    kms_master_key_arn: ?[]const u8 = null,

    /// The type of server-side encryption.
    sse_type: ?[]const u8 = null,

    /// The status of the server-side encryption.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .inaccessible_encryption_date_time = "InaccessibleEncryptionDateTime",
        .kms_master_key_arn = "KmsMasterKeyArn",
        .sse_type = "SseType",
        .status = "Status",
    };
};
