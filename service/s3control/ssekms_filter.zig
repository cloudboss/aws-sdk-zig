/// A filter that returns objects that are encrypted by server-side encryption
/// with Amazon Web Services KMS (SSE-KMS).
pub const SSEKMSFilter = struct {
    /// Specifies whether Amazon S3 should use an S3 Bucket Key for object
    /// encryption with server-side encryption using Amazon Web Services Key
    /// Management Service (Amazon Web Services KMS) keys (SSE-KMS). If specified,
    /// will filter SSE-KMS encrypted objects by S3 Bucket Key status.
    bucket_key_enabled: ?bool = null,

    /// The Amazon Resource Name (ARN) of the customer managed KMS key to use for
    /// the filter to return objects that are encrypted by the specified key. For
    /// best performance, use keys in the same Region as the S3 Batch Operations
    /// job.
    kms_key_arn: ?[]const u8 = null,
};
