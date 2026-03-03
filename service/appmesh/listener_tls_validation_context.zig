const SubjectAlternativeNames = @import("subject_alternative_names.zig").SubjectAlternativeNames;
const ListenerTlsValidationContextTrust = @import("listener_tls_validation_context_trust.zig").ListenerTlsValidationContextTrust;

/// An object that represents a listener's Transport Layer Security (TLS)
/// validation context.
pub const ListenerTlsValidationContext = struct {
    /// A reference to an object that represents the SANs for a listener's Transport
    /// Layer Security (TLS) validation
    /// context.
    subject_alternative_names: ?SubjectAlternativeNames = null,

    /// A reference to where to retrieve the trust chain when validating a peer’s
    /// Transport Layer Security (TLS)
    /// certificate.
    trust: ListenerTlsValidationContextTrust,

    pub const json_field_names = .{
        .subject_alternative_names = "subjectAlternativeNames",
        .trust = "trust",
    };
};
