/// Describes the Amazon S3 bucket name and location for the grammar
/// that is the source for the slot type.
pub const GrammarSlotTypeSource = struct {
    /// The KMS key required to decrypt the contents of the grammar, if any.
    kms_key_arn: ?[]const u8,

    /// The name of the Amazon S3 bucket that contains the grammar source.
    s_3_bucket_name: []const u8,

    /// The path to the grammar in the Amazon S3 bucket.
    s_3_object_key: []const u8,

    pub const json_field_names = .{
        .kms_key_arn = "kmsKeyArn",
        .s_3_bucket_name = "s3BucketName",
        .s_3_object_key = "s3ObjectKey",
    };
};
