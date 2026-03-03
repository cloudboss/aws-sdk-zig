const EncryptionType = @import("encryption_type.zig").EncryptionType;

/// Contains information about the encryption used to store the job results in
/// Amazon S3.
pub const Encryption = struct {
    /// The server-side encryption algorithm used when storing job results in Amazon
    /// S3, for
    /// example `AES256` or `aws:kms`.
    encryption_type: ?EncryptionType = null,

    /// Optional. If the encryption type is `aws:kms`, you can use this value to
    /// specify the encryption context for the job results.
    kms_context: ?[]const u8 = null,

    /// The AWS KMS key ID to use for object encryption. All GET and PUT requests
    /// for an
    /// object protected by AWS KMS fail if not made by using Secure Sockets Layer
    /// (SSL) or
    /// Signature Version 4.
    kms_key_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .encryption_type = "EncryptionType",
        .kms_context = "KMSContext",
        .kms_key_id = "KMSKeyId",
    };
};
