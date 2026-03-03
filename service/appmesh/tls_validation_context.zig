const SubjectAlternativeNames = @import("subject_alternative_names.zig").SubjectAlternativeNames;
const TlsValidationContextTrust = @import("tls_validation_context_trust.zig").TlsValidationContextTrust;

/// An object that represents how the proxy will validate its peer during
/// Transport Layer Security (TLS)
/// negotiation.
pub const TlsValidationContext = struct {
    /// A reference to an object that represents the SANs for a Transport Layer
    /// Security (TLS) validation context. If you
    /// don't specify SANs on the *terminating* mesh endpoint, the Envoy proxy
    /// for that node doesn't verify the SAN on a peer client certificate. If you
    /// don't specify
    /// SANs on the *originating* mesh endpoint, the SAN on the certificate
    /// provided by the terminating endpoint must match the mesh endpoint service
    /// discovery
    /// configuration. Since SPIRE vended certificates have a SPIFFE ID as a name,
    /// you must set the
    /// SAN since the name doesn't match the service discovery name.
    subject_alternative_names: ?SubjectAlternativeNames = null,

    /// A reference to where to retrieve the trust chain when validating a peer’s
    /// Transport Layer Security (TLS)
    /// certificate.
    trust: TlsValidationContextTrust,

    pub const json_field_names = .{
        .subject_alternative_names = "subjectAlternativeNames",
        .trust = "trust",
    };
};
