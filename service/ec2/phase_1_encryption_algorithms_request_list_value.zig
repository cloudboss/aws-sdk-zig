/// Specifies the encryption algorithm for the VPN tunnel for phase 1 IKE
/// negotiations.
pub const Phase1EncryptionAlgorithmsRequestListValue = struct {
    /// The value for the encryption algorithm.
    value: ?[]const u8 = null,
};
