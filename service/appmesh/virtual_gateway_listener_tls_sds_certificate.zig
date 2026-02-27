/// An object that represents the virtual gateway's listener's Secret Discovery
/// Service
/// certificate.The proxy must be configured with a local SDS provider via a
/// Unix Domain
/// Socket. See App Mesh[TLS
/// documentation](https://docs.aws.amazon.com/app-mesh/latest/userguide/tls.html) for more info.
pub const VirtualGatewayListenerTlsSdsCertificate = struct {
    /// A reference to an object that represents the name of the secret secret
    /// requested from
    /// the Secret Discovery Service provider representing Transport Layer Security
    /// (TLS) materials like a certificate or
    /// certificate chain.
    secret_name: []const u8,

    pub const json_field_names = .{
        .secret_name = "secretName",
    };
};
