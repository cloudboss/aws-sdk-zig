/// An object that represents a Transport Layer Security (TLS) validation
/// context trust for a local file.
pub const TlsValidationContextFileTrust = struct {
    /// The certificate trust chain for a certificate stored on the file system of
    /// the virtual
    /// node that the proxy is running on.
    certificate_chain: []const u8,

    pub const json_field_names = .{
        .certificate_chain = "certificateChain",
    };
};
