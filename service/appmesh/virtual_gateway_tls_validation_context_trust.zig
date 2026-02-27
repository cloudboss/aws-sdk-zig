const VirtualGatewayTlsValidationContextAcmTrust = @import("virtual_gateway_tls_validation_context_acm_trust.zig").VirtualGatewayTlsValidationContextAcmTrust;
const VirtualGatewayTlsValidationContextFileTrust = @import("virtual_gateway_tls_validation_context_file_trust.zig").VirtualGatewayTlsValidationContextFileTrust;
const VirtualGatewayTlsValidationContextSdsTrust = @import("virtual_gateway_tls_validation_context_sds_trust.zig").VirtualGatewayTlsValidationContextSdsTrust;

/// An object that represents a Transport Layer Security (TLS) validation
/// context trust.
pub const VirtualGatewayTlsValidationContextTrust = union(enum) {
    /// A reference to an object that represents a Transport Layer Security (TLS)
    /// validation context trust for an Certificate Manager certificate.
    acm: ?VirtualGatewayTlsValidationContextAcmTrust,
    /// An object that represents a Transport Layer Security (TLS) validation
    /// context trust for a local file.
    file: ?VirtualGatewayTlsValidationContextFileTrust,
    /// A reference to an object that represents a virtual gateway's Transport Layer
    /// Security (TLS) Secret Discovery
    /// Service validation context trust.
    sds: ?VirtualGatewayTlsValidationContextSdsTrust,

    pub const json_field_names = .{
        .acm = "acm",
        .file = "file",
        .sds = "sds",
    };
};
