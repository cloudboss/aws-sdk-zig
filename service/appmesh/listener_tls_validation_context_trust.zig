const TlsValidationContextFileTrust = @import("tls_validation_context_file_trust.zig").TlsValidationContextFileTrust;
const TlsValidationContextSdsTrust = @import("tls_validation_context_sds_trust.zig").TlsValidationContextSdsTrust;

/// An object that represents a listener's Transport Layer Security (TLS)
/// validation context trust.
pub const ListenerTlsValidationContextTrust = union(enum) {
    /// An object that represents a Transport Layer Security (TLS) validation
    /// context trust for a local file.
    file: ?TlsValidationContextFileTrust,
    /// A reference to an object that represents a listener's Transport Layer
    /// Security (TLS) Secret Discovery Service
    /// validation context trust.
    sds: ?TlsValidationContextSdsTrust,

    pub const json_field_names = .{
        .file = "file",
        .sds = "sds",
    };
};
