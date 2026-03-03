const CodeSigningCertificateChain = @import("code_signing_certificate_chain.zig").CodeSigningCertificateChain;
const CodeSigningSignature = @import("code_signing_signature.zig").CodeSigningSignature;

/// Describes a custom method used to code sign a file.
pub const CustomCodeSigning = struct {
    /// The certificate chain.
    certificate_chain: ?CodeSigningCertificateChain = null,

    /// The hash algorithm used to code sign the file. You can use a string as the
    /// algorithm name if the target over-the-air (OTA) update devices are able to
    /// verify the signature that was generated using the same signature algorithm.
    /// For example, FreeRTOS uses `SHA256` or `SHA1`, so you can pass either of
    /// them based on which was used for generating the signature.
    hash_algorithm: ?[]const u8 = null,

    /// The signature for the file.
    signature: ?CodeSigningSignature = null,

    /// The signature algorithm used to code sign the file. You can use a string as
    /// the algorithm name if the target over-the-air (OTA) update devices are able
    /// to verify the signature that was generated using the same signature
    /// algorithm. For example, FreeRTOS uses `ECDSA` or `RSA`, so you can pass
    /// either of them based on which was used for generating the signature.
    signature_algorithm: ?[]const u8 = null,

    pub const json_field_names = .{
        .certificate_chain = "certificateChain",
        .hash_algorithm = "hashAlgorithm",
        .signature = "signature",
        .signature_algorithm = "signatureAlgorithm",
    };
};
