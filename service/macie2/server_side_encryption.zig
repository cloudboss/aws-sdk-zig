const EncryptionType = @import("encryption_type.zig").EncryptionType;

/// Provides information about the default server-side encryption settings for
/// an S3 bucket or the encryption settings for an S3 object.
pub const ServerSideEncryption = struct {
    /// The server-side encryption algorithm that's used when storing data in the
    /// bucket or object. If default encryption settings aren't configured for the
    /// bucket or the object isn't encrypted using server-side encryption, this
    /// value is NONE.
    encryption_type: ?EncryptionType,

    /// The Amazon Resource Name (ARN) or unique identifier (key ID) for the KMS key
    /// that's used to encrypt data in the bucket or the object. This value is null
    /// if an KMS key isn't used to encrypt the data.
    kms_master_key_id: ?[]const u8,

    pub const json_field_names = .{
        .encryption_type = "encryptionType",
        .kms_master_key_id = "kmsMasterKeyId",
    };
};
