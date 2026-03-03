const VirtualGatewayListenerTlsCertificate = @import("virtual_gateway_listener_tls_certificate.zig").VirtualGatewayListenerTlsCertificate;
const VirtualGatewayListenerTlsMode = @import("virtual_gateway_listener_tls_mode.zig").VirtualGatewayListenerTlsMode;
const VirtualGatewayListenerTlsValidationContext = @import("virtual_gateway_listener_tls_validation_context.zig").VirtualGatewayListenerTlsValidationContext;

/// An object that represents the Transport Layer Security (TLS) properties for
/// a listener.
pub const VirtualGatewayListenerTls = struct {
    /// An object that represents a Transport Layer Security (TLS) certificate.
    certificate: VirtualGatewayListenerTlsCertificate,

    /// Specify one of the following modes.
    ///
    /// * STRICT – Listener only accepts connections with TLS
    /// enabled.
    ///
    /// * PERMISSIVE – Listener accepts connections with or
    /// without TLS enabled.
    ///
    /// * DISABLED – Listener only accepts connections without
    /// TLS.
    mode: VirtualGatewayListenerTlsMode,

    /// A reference to an object that represents a virtual gateway's listener's
    /// Transport Layer Security (TLS) validation
    /// context.
    validation: ?VirtualGatewayListenerTlsValidationContext = null,

    pub const json_field_names = .{
        .certificate = "certificate",
        .mode = "mode",
        .validation = "validation",
    };
};
