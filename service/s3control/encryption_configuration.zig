/// Specifies encryption-related information for an Amazon S3 bucket that is a
/// destination for
/// replicated objects. If you're specifying a customer managed KMS key, we
/// recommend using a fully qualified
/// KMS key ARN. If you use a KMS key alias instead, then KMS resolves the key
/// within the
/// requester’s account. This behavior can result in data that's encrypted with
/// a KMS key
/// that belongs to the requester, and not the bucket owner.
///
/// This is not supported by Amazon S3 on Outposts buckets.
pub const EncryptionConfiguration = struct {
    /// Specifies the ID of the customer managed KMS key that's stored in Key
    /// Management Service (KMS)
    /// for the destination bucket. This ID is either the Amazon Resource Name (ARN)
    /// for the
    /// KMS key or the alias ARN for the KMS key. Amazon S3 uses this KMS key to
    /// encrypt
    /// replica objects. Amazon S3 supports only symmetric encryption KMS keys. For
    /// more information,
    /// see [Symmetric encryption
    /// KMS
    /// keys](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#symmetric-cmks) in the *Amazon Web Services Key Management Service Developer
    /// Guide*.
    replica_kms_key_id: ?[]const u8 = null,
};
