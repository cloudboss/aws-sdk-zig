const VirtualGatewayClientTlsCertificate = @import("virtual_gateway_client_tls_certificate.zig").VirtualGatewayClientTlsCertificate;
const VirtualGatewayTlsValidationContext = @import("virtual_gateway_tls_validation_context.zig").VirtualGatewayTlsValidationContext;

/// An object that represents a Transport Layer Security (TLS) client policy.
pub const VirtualGatewayClientPolicyTls = struct {
    /// A reference to an object that represents a virtual gateway's client's
    /// Transport Layer Security (TLS)
    /// certificate.
    certificate: ?VirtualGatewayClientTlsCertificate,

    /// Whether the policy is enforced. The default is `True`, if a value isn't
    /// specified.
    enforce: ?bool,

    /// One or more ports that the policy is enforced for.
    ports: ?[]const i32,

    /// A reference to an object that represents a Transport Layer Security (TLS)
    /// validation context.
    validation: VirtualGatewayTlsValidationContext,

    pub const json_field_names = .{
        .certificate = "certificate",
        .enforce = "enforce",
        .ports = "ports",
        .validation = "validation",
    };
};
