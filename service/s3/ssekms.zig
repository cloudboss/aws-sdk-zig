/// Specifies the use of SSE-KMS to encrypt delivered inventory reports.
pub const SSEKMS = struct {
    /// Specifies the ID of the Key Management Service (KMS) symmetric encryption
    /// customer managed key to use for encrypting
    /// inventory reports.
    key_id: []const u8,
};
