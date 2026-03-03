/// Contains the configuration for server-side encryption.
pub const ServerSideEncryptionConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the KMS key used to encrypt the resource.
    kms_key_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .kms_key_arn = "kmsKeyArn",
    };
};
