const ServerSideEncryption = @import("server_side_encryption.zig").ServerSideEncryption;

/// Contains the type of server-side encryption used.
pub const Encryption = struct {
    /// The server-side encryption algorithm used when storing job results in Amazon
    /// S3 (for example, AES256,
    /// `aws:kms`).
    encryption_type: ServerSideEncryption,

    /// If the encryption type is `aws:kms`, this optional value can be used to
    /// specify the
    /// encryption context for the restore results.
    kms_context: ?[]const u8,

    /// If the encryption type is `aws:kms`, this optional value specifies the ID of
    /// the
    /// symmetric encryption customer managed key to use for encryption of job
    /// results. Amazon S3 only supports symmetric
    /// encryption KMS keys. For more information, see [Asymmetric keys in
    /// KMS](https://docs.aws.amazon.com/kms/latest/developerguide/symmetric-asymmetric.html) in the
    /// *Amazon Web Services Key Management Service Developer Guide*.
    kms_key_id: ?[]const u8,
};
