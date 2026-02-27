const KeyAttributes = @import("key_attributes.zig").KeyAttributes;

/// Parameter information for trusted public key certificate import.
pub const TrustedCertificatePublicKey = struct {
    /// The `KeyARN` of the root public key certificate or certificate chain that
    /// signs the trusted public key certificate import.
    certificate_authority_public_key_identifier: []const u8,

    /// The role of the key, the algorithm it supports, and the cryptographic
    /// operations allowed with the key. This data is immutable after a trusted
    /// public key is imported.
    key_attributes: KeyAttributes,

    /// Parameter information for trusted public key certificate import.
    public_key_certificate: []const u8,

    pub const json_field_names = .{
        .certificate_authority_public_key_identifier = "CertificateAuthorityPublicKeyIdentifier",
        .key_attributes = "KeyAttributes",
        .public_key_certificate = "PublicKeyCertificate",
    };
};
