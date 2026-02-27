/// Configuration for the use of SSE-KMS to encrypt generated manifest objects.
pub const SSEKMSEncryption = struct {
    /// Specifies the ID of the Amazon Web Services Key Management Service (Amazon
    /// Web Services KMS) symmetric encryption
    /// customer managed key to use for encrypting generated manifest objects.
    key_id: []const u8,
};
