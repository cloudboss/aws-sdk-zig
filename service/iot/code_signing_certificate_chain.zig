/// Describes the certificate chain being used when code signing a file.
pub const CodeSigningCertificateChain = struct {
    /// The name of the certificate.
    certificate_name: ?[]const u8 = null,

    /// A base64 encoded binary representation of the code signing certificate
    /// chain.
    inline_document: ?[]const u8 = null,

    pub const json_field_names = .{
        .certificate_name = "certificateName",
        .inline_document = "inlineDocument",
    };
};
