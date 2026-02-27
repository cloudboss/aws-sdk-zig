const SSEKMSEncryption = @import("ssekms_encryption.zig").SSEKMSEncryption;
const SSES3Encryption = @import("sses3_encryption.zig").SSES3Encryption;

/// The encryption configuration to use when storing the generated manifest.
pub const GeneratedManifestEncryption = struct {
    /// Configuration details on how SSE-KMS is used to encrypt generated manifest
    /// objects.
    ssekms: ?SSEKMSEncryption,

    /// Specifies the use of SSE-S3 to encrypt generated manifest objects.
    sses3: ?SSES3Encryption,
};
