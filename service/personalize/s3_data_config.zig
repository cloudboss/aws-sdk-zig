/// The configuration details of an Amazon S3 input or output bucket.
pub const S3DataConfig = struct {
    /// The Amazon Resource Name (ARN) of the Key Management Service (KMS) key that
    /// Amazon Personalize uses to
    /// encrypt or decrypt the input and output files.
    kms_key_arn: ?[]const u8 = null,

    /// The file path of the Amazon S3 bucket.
    path: []const u8,

    pub const json_field_names = .{
        .kms_key_arn = "kmsKeyArn",
        .path = "path",
    };
};
