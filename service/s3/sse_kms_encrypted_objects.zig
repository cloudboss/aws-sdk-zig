const SseKmsEncryptedObjectsStatus = @import("sse_kms_encrypted_objects_status.zig").SseKmsEncryptedObjectsStatus;

/// A container for filter information for the selection of S3 objects encrypted
/// with Amazon Web Services KMS.
pub const SseKmsEncryptedObjects = struct {
    /// Specifies whether Amazon S3 replicates objects created with server-side
    /// encryption using an Amazon Web Services KMS key
    /// stored in Amazon Web Services Key Management Service.
    status: SseKmsEncryptedObjectsStatus,
};
