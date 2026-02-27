const VirtualGatewayListenerTlsAcmCertificate = @import("virtual_gateway_listener_tls_acm_certificate.zig").VirtualGatewayListenerTlsAcmCertificate;
const VirtualGatewayListenerTlsFileCertificate = @import("virtual_gateway_listener_tls_file_certificate.zig").VirtualGatewayListenerTlsFileCertificate;
const VirtualGatewayListenerTlsSdsCertificate = @import("virtual_gateway_listener_tls_sds_certificate.zig").VirtualGatewayListenerTlsSdsCertificate;

/// An object that represents a listener's Transport Layer Security (TLS)
/// certificate.
pub const VirtualGatewayListenerTlsCertificate = union(enum) {
    /// A reference to an object that represents an Certificate Manager certificate.
    acm: ?VirtualGatewayListenerTlsAcmCertificate,
    /// A reference to an object that represents a local file certificate.
    file: ?VirtualGatewayListenerTlsFileCertificate,
    /// A reference to an object that represents a virtual gateway's listener's
    /// Secret Discovery
    /// Service certificate.
    sds: ?VirtualGatewayListenerTlsSdsCertificate,

    pub const json_field_names = .{
        .acm = "acm",
        .file = "file",
        .sds = "sds",
    };
};
