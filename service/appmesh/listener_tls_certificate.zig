const ListenerTlsAcmCertificate = @import("listener_tls_acm_certificate.zig").ListenerTlsAcmCertificate;
const ListenerTlsFileCertificate = @import("listener_tls_file_certificate.zig").ListenerTlsFileCertificate;
const ListenerTlsSdsCertificate = @import("listener_tls_sds_certificate.zig").ListenerTlsSdsCertificate;

/// An object that represents a listener's Transport Layer Security (TLS)
/// certificate.
pub const ListenerTlsCertificate = union(enum) {
    /// A reference to an object that represents an Certificate Manager certificate.
    acm: ?ListenerTlsAcmCertificate,
    /// A reference to an object that represents a local file certificate.
    file: ?ListenerTlsFileCertificate,
    /// A reference to an object that represents a listener's Secret Discovery
    /// Service
    /// certificate.
    sds: ?ListenerTlsSdsCertificate,

    pub const json_field_names = .{
        .acm = "acm",
        .file = "file",
        .sds = "sds",
    };
};
