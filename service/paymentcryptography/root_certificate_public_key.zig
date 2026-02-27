const KeyAttributes = @import("key_attributes.zig").KeyAttributes;

/// Parameter information for root public key certificate import.
pub const RootCertificatePublicKey = struct {
    /// The role of the key, the algorithm it supports, and the cryptographic
    /// operations allowed with the key. This data is immutable after the root
    /// public key is imported.
    key_attributes: KeyAttributes,

    /// Parameter information for root public key certificate import.
    public_key_certificate: []const u8,

    pub const json_field_names = .{
        .key_attributes = "KeyAttributes",
        .public_key_certificate = "PublicKeyCertificate",
    };
};
