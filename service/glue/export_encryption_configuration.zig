/// The encryption configuration for exported data catalog metadata.
pub const ExportEncryptionConfiguration = struct {
    /// The ARN of the KMS key used to encrypt the exported data.
    kms_key_arn: ?[]const u8 = null,

    /// The server-side encryption algorithm used for the exported data. Valid
    /// values are `AES256` and `aws:kms`.
    sse_algorithm: ?[]const u8 = null,

    pub const json_field_names = .{
        .kms_key_arn = "KmsKeyArn",
        .sse_algorithm = "SseAlgorithm",
    };
};
