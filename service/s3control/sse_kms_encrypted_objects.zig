const SseKmsEncryptedObjectsStatus = @import("sse_kms_encrypted_objects_status.zig").SseKmsEncryptedObjectsStatus;

/// A container for filter information that you can use to select S3 objects
/// that are
/// encrypted with Key Management Service (KMS).
///
/// This is not supported by Amazon S3 on Outposts buckets.
pub const SseKmsEncryptedObjects = struct {
    /// Specifies whether Amazon S3 replicates objects that are created with
    /// server-side encryption
    /// by using an KMS key stored in Key Management Service.
    status: SseKmsEncryptedObjectsStatus,
};
