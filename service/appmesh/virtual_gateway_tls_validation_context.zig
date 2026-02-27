const SubjectAlternativeNames = @import("subject_alternative_names.zig").SubjectAlternativeNames;
const VirtualGatewayTlsValidationContextTrust = @import("virtual_gateway_tls_validation_context_trust.zig").VirtualGatewayTlsValidationContextTrust;

/// An object that represents a Transport Layer Security (TLS) validation
/// context.
pub const VirtualGatewayTlsValidationContext = struct {
    /// A reference to an object that represents the SANs for a virtual gateway's
    /// listener's
    /// Transport Layer Security (TLS) validation context.
    subject_alternative_names: ?SubjectAlternativeNames,

    /// A reference to where to retrieve the trust chain when validating a peer’s
    /// Transport Layer Security (TLS)
    /// certificate.
    trust: VirtualGatewayTlsValidationContextTrust,

    pub const json_field_names = .{
        .subject_alternative_names = "subjectAlternativeNames",
        .trust = "trust",
    };
};
