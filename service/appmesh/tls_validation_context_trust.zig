const TlsValidationContextAcmTrust = @import("tls_validation_context_acm_trust.zig").TlsValidationContextAcmTrust;
const TlsValidationContextFileTrust = @import("tls_validation_context_file_trust.zig").TlsValidationContextFileTrust;
const TlsValidationContextSdsTrust = @import("tls_validation_context_sds_trust.zig").TlsValidationContextSdsTrust;

/// An object that represents a Transport Layer Security (TLS) validation
/// context trust.
pub const TlsValidationContextTrust = union(enum) {
    /// A reference to an object that represents a Transport Layer Security (TLS)
    /// validation context trust for an Certificate Manager certificate.
    acm: ?TlsValidationContextAcmTrust,
    /// An object that represents a Transport Layer Security (TLS) validation
    /// context trust for a local file.
    file: ?TlsValidationContextFileTrust,
    /// A reference to an object that represents a Transport Layer Security (TLS)
    /// Secret Discovery Service validation
    /// context trust.
    sds: ?TlsValidationContextSdsTrust,

    pub const json_field_names = .{
        .acm = "acm",
        .file = "file",
        .sds = "sds",
    };
};
