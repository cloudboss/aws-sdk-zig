const DecryptionMode = @import("decryption_mode.zig").DecryptionMode;

/// Settings for decrypting any input files that you encrypt before you upload
/// them to Amazon S3. MediaConvert can decrypt files only when you use AWS Key
/// Management Service (KMS) to encrypt the data key that you use to encrypt
/// your content.
pub const InputDecryptionSettings = struct {
    /// Specify the encryption mode that you used to encrypt your input files.
    decryption_mode: ?DecryptionMode = null,

    /// Warning! Don't provide your encryption key in plaintext. Your job settings
    /// could be intercepted, making your encrypted content vulnerable. Specify the
    /// encrypted version of the data key that you used to encrypt your content. The
    /// data key must be encrypted by AWS Key Management Service (KMS). The key can
    /// be 128, 192, or 256 bits.
    encrypted_decryption_key: ?[]const u8 = null,

    /// Specify the initialization vector that you used when you encrypted your
    /// content before uploading it to Amazon S3. You can use a 16-byte
    /// initialization vector with any encryption mode. Or, you can use a 12-byte
    /// initialization vector with GCM or CTR. MediaConvert accepts only
    /// initialization vectors that are base64-encoded.
    initialization_vector: ?[]const u8 = null,

    /// Specify the AWS Region for AWS Key Management Service (KMS) that you used to
    /// encrypt your data key, if that Region is different from the one you are
    /// using for AWS Elemental MediaConvert.
    kms_key_region: ?[]const u8 = null,

    pub const json_field_names = .{
        .decryption_mode = "DecryptionMode",
        .encrypted_decryption_key = "EncryptedDecryptionKey",
        .initialization_vector = "InitializationVector",
        .kms_key_region = "KmsKeyRegion",
    };
};
