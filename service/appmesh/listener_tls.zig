const ListenerTlsCertificate = @import("listener_tls_certificate.zig").ListenerTlsCertificate;
const ListenerTlsMode = @import("listener_tls_mode.zig").ListenerTlsMode;
const ListenerTlsValidationContext = @import("listener_tls_validation_context.zig").ListenerTlsValidationContext;

/// An object that represents the Transport Layer Security (TLS) properties for
/// a listener.
pub const ListenerTls = struct {
    /// A reference to an object that represents a listener's Transport Layer
    /// Security (TLS) certificate.
    certificate: ListenerTlsCertificate,

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
    mode: ListenerTlsMode,

    /// A reference to an object that represents a listener's Transport Layer
    /// Security (TLS) validation context.
    validation: ?ListenerTlsValidationContext,

    pub const json_field_names = .{
        .certificate = "certificate",
        .mode = "mode",
        .validation = "validation",
    };
};
