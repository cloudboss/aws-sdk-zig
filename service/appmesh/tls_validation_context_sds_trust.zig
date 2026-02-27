/// An object that represents a Transport Layer Security (TLS) Secret Discovery
/// Service validation context trust. The
/// proxy must be configured with a local SDS provider via a Unix Domain Socket.
/// See App Mesh
/// [TLS
/// documentation](https://docs.aws.amazon.com/app-mesh/latest/userguide/tls.html) for more info.
pub const TlsValidationContextSdsTrust = struct {
    /// A reference to an object that represents the name of the secret for a
    /// Transport Layer Security (TLS) Secret
    /// Discovery Service validation context trust.
    secret_name: []const u8,

    pub const json_field_names = .{
        .secret_name = "secretName",
    };
};
