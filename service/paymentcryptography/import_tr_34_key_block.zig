const Tr34KeyBlockFormat = @import("tr_34_key_block_format.zig").Tr34KeyBlockFormat;

/// Parameter information for key material import using the asymmetric TR-34 key
/// exchange method.
pub const ImportTr34KeyBlock = struct {
    /// The `KeyARN` of the certificate chain that signs the signing key certificate
    /// during TR-34 key import.
    certificate_authority_public_key_identifier: []const u8,

    /// The import token that initiates key import using the asymmetric TR-34 key
    /// exchange method into Amazon Web Services Payment Cryptography. It expires
    /// after 30 days. You can use the same import token to import multiple keys to
    /// the same service account.
    import_token: []const u8 = "",

    /// The key block format to use during key import. The only value allowed is
    /// `X9_TR34_2012`.
    key_block_format: Tr34KeyBlockFormat,

    /// A random number value that is unique to the TR-34 key block generated using
    /// 2 pass. The operation will fail, if a random nonce value is not provided for
    /// a TR-34 key block generated using 2 pass.
    random_nonce: ?[]const u8,

    /// The public key component in PEM certificate format of the private key that
    /// signs the KDH TR-34 WrappedKeyBlock.
    signing_key_certificate: []const u8,

    /// The TR-34 wrapped key block to import.
    wrapped_key_block: []const u8,

    /// The certificate used to wrap the TR-34 key block.
    wrapping_key_certificate: ?[]const u8,

    /// Key Identifier used for unwrapping the import key
    wrapping_key_identifier: ?[]const u8,

    pub const json_field_names = .{
        .certificate_authority_public_key_identifier = "CertificateAuthorityPublicKeyIdentifier",
        .import_token = "ImportToken",
        .key_block_format = "KeyBlockFormat",
        .random_nonce = "RandomNonce",
        .signing_key_certificate = "SigningKeyCertificate",
        .wrapped_key_block = "WrappedKeyBlock",
        .wrapping_key_certificate = "WrappingKeyCertificate",
        .wrapping_key_identifier = "WrappingKeyIdentifier",
    };
};
