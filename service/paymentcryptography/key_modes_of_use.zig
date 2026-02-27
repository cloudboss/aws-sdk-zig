/// The list of cryptographic operations that you can perform using the key. The
/// modes of use are deﬁned in section A.5.3 of the TR-31 spec.
pub const KeyModesOfUse = struct {
    /// Speciﬁes whether an Amazon Web Services Payment Cryptography key can be used
    /// to decrypt data.
    decrypt: bool = false,

    /// Speciﬁes whether an Amazon Web Services Payment Cryptography key can be used
    /// to derive new keys.
    derive_key: bool = false,

    /// Speciﬁes whether an Amazon Web Services Payment Cryptography key can be used
    /// to encrypt data.
    encrypt: bool = false,

    /// Speciﬁes whether an Amazon Web Services Payment Cryptography key can be used
    /// to generate and verify other card and PIN verification keys.
    generate: bool = false,

    /// Speciﬁes whether an Amazon Web Services Payment Cryptography key has no
    /// special restrictions other than the restrictions implied by `KeyUsage`.
    no_restrictions: bool = false,

    /// Speciﬁes whether an Amazon Web Services Payment Cryptography key can be used
    /// for signing.
    sign: bool = false,

    /// Speciﬁes whether an Amazon Web Services Payment Cryptography key can be used
    /// to unwrap other keys.
    unwrap: bool = false,

    /// Speciﬁes whether an Amazon Web Services Payment Cryptography key can be used
    /// to verify signatures.
    verify: bool = false,

    /// Speciﬁes whether an Amazon Web Services Payment Cryptography key can be used
    /// to wrap other keys.
    wrap: bool = false,

    pub const json_field_names = .{
        .decrypt = "Decrypt",
        .derive_key = "DeriveKey",
        .encrypt = "Encrypt",
        .generate = "Generate",
        .no_restrictions = "NoRestrictions",
        .sign = "Sign",
        .unwrap = "Unwrap",
        .verify = "Verify",
        .wrap = "Wrap",
    };
};
