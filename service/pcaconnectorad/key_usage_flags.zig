/// The key usage flags represent the purpose (e.g., encipherment, signature) of
/// the key
/// contained in the certificate.
pub const KeyUsageFlags = struct {
    /// DataEncipherment is asserted when the subject public key is used for
    /// directly
    /// enciphering raw user data without the use of an intermediate symmetric
    /// cipher.
    data_encipherment: ?bool = null,

    /// The digitalSignature is asserted when the subject public key is used for
    /// verifying
    /// digital signatures.
    digital_signature: ?bool = null,

    /// KeyAgreement is asserted when the subject public key is used for key
    /// agreement.
    key_agreement: ?bool = null,

    /// KeyEncipherment is asserted when the subject public key is used for
    /// enciphering private
    /// or secret keys, i.e., for key transport.
    key_encipherment: ?bool = null,

    /// NonRepudiation is asserted when the subject public key is used to verify
    /// digital
    /// signatures.
    non_repudiation: ?bool = null,

    pub const json_field_names = .{
        .data_encipherment = "DataEncipherment",
        .digital_signature = "DigitalSignature",
        .key_agreement = "KeyAgreement",
        .key_encipherment = "KeyEncipherment",
        .non_repudiation = "NonRepudiation",
    };
};
