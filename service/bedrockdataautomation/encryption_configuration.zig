const aws = @import("aws");

/// KMS Encryption Configuration
pub const EncryptionConfiguration = struct {
    kms_encryption_context: ?[]const aws.map.StringMapEntry = null,

    kms_key_id: []const u8,

    pub const json_field_names = .{
        .kms_encryption_context = "kmsEncryptionContext",
        .kms_key_id = "kmsKeyId",
    };
};
