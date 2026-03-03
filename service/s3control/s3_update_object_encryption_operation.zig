const ObjectEncryption = @import("object_encryption.zig").ObjectEncryption;

/// With the `UpdateObjectEncryption` operation, you can atomically
/// update the server-side encryption type of an existing object in a general
/// purpose bucket without any data movement.
pub const S3UpdateObjectEncryptionOperation = struct {
    /// The updated server-side encryption type for this S3 object. The
    /// `UpdateObjectEncryption` operation supports the
    /// SSE-KMS encryption type.
    object_encryption: ?ObjectEncryption = null,
};
