const aws = @import("aws");

/// Encryption configuration.
pub const EncryptionConfiguration = struct {
    /// KMS encryption context.
    kms_encryption_context: ?[]const aws.map.StringMapEntry = null,

    /// Customer KMS key used for encryption
    kms_key_id: []const u8,

    pub const json_field_names = .{
        .kms_encryption_context = "kmsEncryptionContext",
        .kms_key_id = "kmsKeyId",
    };
};
