const S3UpdateObjectEncryptionSSEKMS = @import("s3_update_object_encryption_ssekms.zig").S3UpdateObjectEncryptionSSEKMS;

/// The updated server-side encryption type for this object. The
/// `UpdateObjectEncryption` operation supports the
/// SSE-KMS encryption type.
///
/// Valid Values: `SSEKMS`
pub const ObjectEncryption = struct {
    /// Specifies to update the object encryption type to server-side encryption
    /// with Key Management Service (KMS) keys (SSE-KMS).
    ssekms: ?S3UpdateObjectEncryptionSSEKMS = null,
};
