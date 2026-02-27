/// Specifies key usage.
pub const KeyUsagePropertyFlags = struct {
    /// Allows key for encryption and decryption.
    decrypt: ?bool,

    /// Allows key exchange without encryption.
    key_agreement: ?bool,

    /// Allow key use for digital signature.
    sign: ?bool,

    pub const json_field_names = .{
        .decrypt = "Decrypt",
        .key_agreement = "KeyAgreement",
        .sign = "Sign",
    };
};
