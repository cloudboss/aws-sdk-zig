/// Placeholder documentation for AccountConfiguration
pub const AccountConfiguration = struct {
    /// Specifies the KMS key to use for all features that use key encryption.
    /// Specify the ARN of a KMS key that you have created. Or leave blank to use
    /// the key that MediaLive creates and manages for you.
    kms_key_id: ?[]const u8,

    pub const json_field_names = .{
        .kms_key_id = "KmsKeyId",
    };
};
