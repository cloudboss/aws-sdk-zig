/// An object that represents a local file certificate.
/// The certificate must meet specific requirements and you must have proxy
/// authorization enabled. For more information, see [Transport Layer Security
/// (TLS)](https://docs.aws.amazon.com/app-mesh/latest/userguide/tls.html#virtual-node-tls-prerequisites).
pub const VirtualGatewayListenerTlsFileCertificate = struct {
    /// The certificate chain for the certificate.
    certificate_chain: []const u8,

    /// The private key for a certificate stored on the file system of the mesh
    /// endpoint that
    /// the proxy is running on.
    private_key: []const u8,

    pub const json_field_names = .{
        .certificate_chain = "certificateChain",
        .private_key = "privateKey",
    };
};
