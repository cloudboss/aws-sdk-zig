const SubjectAlternativeNames = @import("subject_alternative_names.zig").SubjectAlternativeNames;
const VirtualGatewayListenerTlsValidationContextTrust = @import("virtual_gateway_listener_tls_validation_context_trust.zig").VirtualGatewayListenerTlsValidationContextTrust;

/// An object that represents a virtual gateway's listener's Transport Layer
/// Security (TLS) validation
/// context.
pub const VirtualGatewayListenerTlsValidationContext = struct {
    /// A reference to an object that represents the SANs for a virtual gateway
    /// listener's Transport Layer Security (TLS)
    /// validation context.
    subject_alternative_names: ?SubjectAlternativeNames = null,

    /// A reference to where to retrieve the trust chain when validating a peer’s
    /// Transport Layer Security (TLS)
    /// certificate.
    trust: VirtualGatewayListenerTlsValidationContextTrust,

    pub const json_field_names = .{
        .subject_alternative_names = "subjectAlternativeNames",
        .trust = "trust",
    };
};
