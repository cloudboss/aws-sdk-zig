const EncryptionType = @import("encryption_type.zig").EncryptionType;

/// The encryption configuration.
pub const EncryptionConfig = struct {
    /// The type of encryption.
    encryption_type: EncryptionType,

    /// The full ARN of the encryption key.
    ///
    /// Be sure to provide the full ARN of the encryption key, not just the ID.
    ///
    /// Amazon Connect supports only KMS keys with the default key spec of [
    /// `SYMMETRIC_DEFAULT`
    /// ](https://docs.aws.amazon.com/kms/latest/developerguide/asymmetric-key-specs.html#key-spec-symmetric-default).
    key_id: []const u8,

    pub const json_field_names = .{
        .encryption_type = "EncryptionType",
        .key_id = "KeyId",
    };
};
