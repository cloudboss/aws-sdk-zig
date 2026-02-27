/// A filter that returns objects that are encrypted by dual-layer server-side
/// encryption with Amazon Web Services Key Management Service (KMS) keys
/// (DSSE-KMS). You can further refine your filtering by optionally providing a
/// KMS Key ARN to filter objects encrypted by a specific key.
pub const DSSEKMSFilter = struct {
    /// The Amazon Resource Name (ARN) of the customer managed KMS key to use for
    /// the filter to return objects that are encrypted by the specified key. For
    /// best performance, use keys in the same Region as the S3 Batch Operations
    /// job.
    kms_key_arn: ?[]const u8,
};
