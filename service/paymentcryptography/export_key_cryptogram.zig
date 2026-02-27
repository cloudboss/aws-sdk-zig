const WrappingKeySpec = @import("wrapping_key_spec.zig").WrappingKeySpec;

/// Parameter information for key material export using asymmetric RSA wrap and
/// unwrap key exchange method.
pub const ExportKeyCryptogram = struct {
    /// The `KeyARN` of the certificate chain that signs the wrapping key
    /// certificate during RSA wrap and unwrap key export.
    certificate_authority_public_key_identifier: []const u8,

    /// The wrapping key certificate in PEM format (base64 encoded). Amazon Web
    /// Services Payment Cryptography uses this certificate to wrap the key under
    /// export.
    wrapping_key_certificate: []const u8,

    /// The wrapping spec for the key under export.
    wrapping_spec: ?WrappingKeySpec,

    pub const json_field_names = .{
        .certificate_authority_public_key_identifier = "CertificateAuthorityPublicKeyIdentifier",
        .wrapping_key_certificate = "WrappingKeyCertificate",
        .wrapping_spec = "WrappingSpec",
    };
};
