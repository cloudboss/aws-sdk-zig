/// Configuration for Amazon S3 destination where scheduled query results are
/// delivered.
pub const S3Configuration = struct {
    /// The Amazon S3 URI where query results are delivered. Must be a valid S3 URI
    /// format.
    destination_identifier: []const u8,

    /// The Amazon Resource Name (ARN) of the KMS encryption key. Must belong to the
    /// same Amazon Web Services Region
    /// as the destination Amazon S3 bucket.
    kms_key_id: ?[]const u8 = null,

    /// The Amazon Web Services accountId for the bucket owning account.
    owner_account_id: ?[]const u8 = null,

    /// The ARN of the IAM role that grants permissions to write query results to
    /// the specified
    /// Amazon S3 destination.
    role_arn: []const u8,

    pub const json_field_names = .{
        .destination_identifier = "destinationIdentifier",
        .kms_key_id = "kmsKeyId",
        .owner_account_id = "ownerAccountId",
        .role_arn = "roleArn",
    };
};
