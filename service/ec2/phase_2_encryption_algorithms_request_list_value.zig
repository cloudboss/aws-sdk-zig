/// Specifies the encryption algorithm for the VPN tunnel for phase 2 IKE
/// negotiations.
pub const Phase2EncryptionAlgorithmsRequestListValue = struct {
    /// The encryption algorithm.
    value: ?[]const u8,
};
