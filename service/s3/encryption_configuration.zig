/// Specifies encryption-related information for an Amazon S3 bucket that is a
/// destination for replicated
/// objects.
///
/// If you're specifying a customer managed KMS key, we recommend using a fully
/// qualified KMS key
/// ARN. If you use a KMS key alias instead, then KMS resolves the key within
/// the requester’s account.
/// This behavior can result in data that's encrypted with a KMS key that
/// belongs to the requester, and
/// not the bucket owner.
pub const EncryptionConfiguration = struct {
    /// Specifies the ID (Key ARN or Alias ARN) of the customer managed Amazon Web
    /// Services KMS key stored in Amazon Web Services Key
    /// Management Service (KMS) for the destination bucket. Amazon S3 uses this key
    /// to encrypt replica objects. Amazon S3
    /// only supports symmetric encryption KMS keys. For more information, see
    /// [Asymmetric keys in Amazon Web Services
    /// KMS](https://docs.aws.amazon.com/kms/latest/developerguide/symmetric-asymmetric.html) in the
    /// *Amazon Web Services Key Management Service Developer Guide*.
    replica_kms_key_id: ?[]const u8,
};
