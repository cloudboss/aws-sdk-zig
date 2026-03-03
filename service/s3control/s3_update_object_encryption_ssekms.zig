/// If `SSEKMS` is specified for `UpdateObjectEncryption`,
/// this data type specifies the Amazon Web Services KMS key Amazon Resource
/// Name (ARN) to use
/// and whether to use an S3 Bucket Key for server-side encryption using
/// Key Management Service (KMS) keys (SSE-KMS).
pub const S3UpdateObjectEncryptionSSEKMS = struct {
    /// Specifies whether Amazon S3 should use an S3 Bucket Key for object
    /// encryption
    /// with server-side encryption using Key Management Service (KMS) keys
    /// (SSE-KMS). If this
    /// value isn't specified, it defaults to `false`. Setting this value
    /// to `true` causes Amazon S3 to use an S3 Bucket Key for update object
    /// encryption with SSE-KMS.
    bucket_key_enabled: ?bool = null,

    /// Specifies the Amazon Web Services KMS key Amazon Resource Name (ARN) to use
    /// for the
    /// updated server-side encryption type. Required if `UpdateObjectEncryption`
    /// specifies `SSEKMS`.
    kms_key_arn: []const u8,
};
