/// The storage configuration for a notebook run in Amazon DataZone.
pub const StorageConfig = struct {
    /// The ARN of the KMS key used for encryption.
    kms_key_arn: ?[]const u8 = null,

    /// The Amazon Simple Storage Service path for the project storage.
    project_s3_path: ?[]const u8 = null,

    pub const json_field_names = .{
        .kms_key_arn = "kmsKeyArn",
        .project_s3_path = "projectS3Path",
    };
};
