/// Specifies the Amazon S3 path and optional encryption settings for training
/// session output data, including checkpoints, model artifacts, and invocation
/// results.
pub const TrainingSessionS3Location = struct {
    /// The Amazon Resource Name (ARN) of the KMS key used to encrypt output data.
    /// If not specified, the default Amazon S3 encryption is used.
    kms_key_arn: ?[]const u8 = null,

    /// The Amazon S3 path where training session outputs are stored.
    path: []const u8,

    pub const json_field_names = .{
        .kms_key_arn = "KmsKeyArn",
        .path = "Path",
    };
};
