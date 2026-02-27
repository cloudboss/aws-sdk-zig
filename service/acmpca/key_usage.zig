/// Defines one or more purposes for which the key contained in the certificate
/// can be used. Default value for each option is false.
pub const KeyUsage = struct {
    /// Key can be used to sign CRLs.
    crl_sign: bool = false,

    /// Key can be used to decipher data.
    data_encipherment: bool = false,

    /// Key can be used only to decipher data.
    decipher_only: bool = false,

    /// Key can be used for digital signing.
    digital_signature: bool = false,

    /// Key can be used only to encipher data.
    encipher_only: bool = false,

    /// Key can be used in a key-agreement protocol.
    key_agreement: bool = false,

    /// Key can be used to sign certificates.
    key_cert_sign: bool = false,

    /// Key can be used to encipher data.
    key_encipherment: bool = false,

    /// Key can be used for non-repudiation.
    non_repudiation: bool = false,

    pub const json_field_names = .{
        .crl_sign = "CRLSign",
        .data_encipherment = "DataEncipherment",
        .decipher_only = "DecipherOnly",
        .digital_signature = "DigitalSignature",
        .encipher_only = "EncipherOnly",
        .key_agreement = "KeyAgreement",
        .key_cert_sign = "KeyCertSign",
        .key_encipherment = "KeyEncipherment",
        .non_repudiation = "NonRepudiation",
    };
};
