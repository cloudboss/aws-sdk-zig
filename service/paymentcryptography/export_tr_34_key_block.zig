const Tr34KeyBlockFormat = @import("tr_34_key_block_format.zig").Tr34KeyBlockFormat;
const KeyBlockHeaders = @import("key_block_headers.zig").KeyBlockHeaders;

/// Parameter information for key material export using the asymmetric TR-34 key
/// exchange method.
pub const ExportTr34KeyBlock = struct {
    /// The `KeyARN` of the certificate chain that signs the wrapping key
    /// certificate during TR-34 key export.
    certificate_authority_public_key_identifier: []const u8,

    /// The export token to initiate key export from Amazon Web Services Payment
    /// Cryptography. It also contains the signing key certificate that will sign
    /// the wrapped key during TR-34 key block generation. Call
    /// [GetParametersForExport](https://docs.aws.amazon.com/payment-cryptography/latest/APIReference/API_GetParametersForExport.html) to receive an export token. It expires after 30 days. You can use the same export token to export multiple keys from the same service account.
    export_token: []const u8 = "",

    /// The format of key block that Amazon Web Services Payment Cryptography will
    /// use during key export.
    key_block_format: Tr34KeyBlockFormat,

    /// Optional metadata for export associated with the key material. This data is
    /// signed but transmitted in clear text.
    key_block_headers: ?KeyBlockHeaders,

    /// A random number value that is unique to the TR-34 key block generated using
    /// 2 pass. The operation will fail, if a random nonce value is not provided for
    /// a TR-34 key block generated using 2 pass.
    random_nonce: ?[]const u8,

    /// The certificate used to sign the TR-34 key block.
    signing_key_certificate: ?[]const u8,

    /// Key Identifier used for signing the export key
    signing_key_identifier: ?[]const u8,

    /// The `KeyARN` of the wrapping key certificate. Amazon Web Services Payment
    /// Cryptography uses this certificate to wrap the key under export.
    wrapping_key_certificate: []const u8,

    pub const json_field_names = .{
        .certificate_authority_public_key_identifier = "CertificateAuthorityPublicKeyIdentifier",
        .export_token = "ExportToken",
        .key_block_format = "KeyBlockFormat",
        .key_block_headers = "KeyBlockHeaders",
        .random_nonce = "RandomNonce",
        .signing_key_certificate = "SigningKeyCertificate",
        .signing_key_identifier = "SigningKeyIdentifier",
        .wrapping_key_certificate = "WrappingKeyCertificate",
    };
};
