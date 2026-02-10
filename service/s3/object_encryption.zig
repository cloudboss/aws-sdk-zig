const SSEKMSEncryption = @import("ssekms_encryption.zig").SSEKMSEncryption;

/// The updated server-side encryption type for this object. The
/// `UpdateObjectEncryption`
/// operation supports the SSE-S3 and SSE-KMS encryption types.
///
/// Valid Values: `SSES3` | `SSEKMS`
pub const ObjectEncryption = union(enum) {
    /// Specifies to update the object encryption type to server-side encryption
    /// with Key Management Service (KMS) keys
    /// (SSE-KMS).
    ssekms: ?SSEKMSEncryption,
};
