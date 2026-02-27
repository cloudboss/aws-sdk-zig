const VirtualGatewayListenerTlsFileCertificate = @import("virtual_gateway_listener_tls_file_certificate.zig").VirtualGatewayListenerTlsFileCertificate;
const VirtualGatewayListenerTlsSdsCertificate = @import("virtual_gateway_listener_tls_sds_certificate.zig").VirtualGatewayListenerTlsSdsCertificate;

/// An object that represents the virtual gateway's client's Transport Layer
/// Security (TLS) certificate.
pub const VirtualGatewayClientTlsCertificate = union(enum) {
    /// An object that represents a local file certificate. The certificate must
    /// meet specific
    /// requirements and you must have proxy authorization enabled. For more
    /// information, see
    /// [ Transport Layer Security (TLS)
    /// ](https://docs.aws.amazon.com/app-mesh/latest/userguide/tls.html).
    file: ?VirtualGatewayListenerTlsFileCertificate,
    /// A reference to an object that represents a virtual gateway's client's Secret
    /// Discovery
    /// Service certificate.
    sds: ?VirtualGatewayListenerTlsSdsCertificate,

    pub const json_field_names = .{
        .file = "file",
        .sds = "sds",
    };
};
