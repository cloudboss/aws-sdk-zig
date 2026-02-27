const ListenerTlsFileCertificate = @import("listener_tls_file_certificate.zig").ListenerTlsFileCertificate;
const ListenerTlsSdsCertificate = @import("listener_tls_sds_certificate.zig").ListenerTlsSdsCertificate;

/// An object that represents the client's certificate.
pub const ClientTlsCertificate = union(enum) {
    /// An object that represents a local file certificate. The certificate must
    /// meet specific
    /// requirements and you must have proxy authorization enabled. For more
    /// information, see
    /// [Transport Layer Security
    /// (TLS)](https://docs.aws.amazon.com/app-mesh/latest/userguide/tls.html).
    file: ?ListenerTlsFileCertificate,
    /// A reference to an object that represents a client's TLS Secret Discovery
    /// Service
    /// certificate.
    sds: ?ListenerTlsSdsCertificate,

    pub const json_field_names = .{
        .file = "file",
        .sds = "sds",
    };
};
