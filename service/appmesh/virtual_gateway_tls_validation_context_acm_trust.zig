/// An object that represents a Transport Layer Security (TLS) validation
/// context trust for an Certificate Manager
/// certificate.
pub const VirtualGatewayTlsValidationContextAcmTrust = struct {
    /// One or more ACM Amazon Resource Name (ARN)s.
    certificate_authority_arns: []const []const u8,

    pub const json_field_names = .{
        .certificate_authority_arns = "certificateAuthorityArns",
    };
};
