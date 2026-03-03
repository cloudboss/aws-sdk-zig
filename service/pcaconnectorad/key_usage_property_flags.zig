/// Specifies key usage.
pub const KeyUsagePropertyFlags = struct {
    /// Allows key for encryption and decryption.
    decrypt: ?bool = null,

    /// Allows key exchange without encryption.
    key_agreement: ?bool = null,

    /// Allow key use for digital signature.
    sign: ?bool = null,

    pub const json_field_names = .{
        .decrypt = "Decrypt",
        .key_agreement = "KeyAgreement",
        .sign = "Sign",
    };
};
