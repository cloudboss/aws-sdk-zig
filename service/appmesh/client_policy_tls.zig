const ClientTlsCertificate = @import("client_tls_certificate.zig").ClientTlsCertificate;
const TlsValidationContext = @import("tls_validation_context.zig").TlsValidationContext;

/// A reference to an object that represents a Transport Layer Security (TLS)
/// client policy.
pub const ClientPolicyTls = struct {
    /// A reference to an object that represents a client's TLS certificate.
    certificate: ?ClientTlsCertificate = null,

    /// Whether the policy is enforced. The default is `True`, if a value isn't
    /// specified.
    enforce: ?bool = null,

    /// One or more ports that the policy is enforced for.
    ports: ?[]const i32 = null,

    /// A reference to an object that represents a TLS validation context.
    validation: TlsValidationContext,

    pub const json_field_names = .{
        .certificate = "certificate",
        .enforce = "enforce",
        .ports = "ports",
        .validation = "validation",
    };
};
