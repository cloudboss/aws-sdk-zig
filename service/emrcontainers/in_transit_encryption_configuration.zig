const TLSCertificateConfiguration = @import("tls_certificate_configuration.zig").TLSCertificateConfiguration;

/// Configurations related to in-transit encryption for the security
/// configuration.
pub const InTransitEncryptionConfiguration = struct {
    /// TLS certificate-related configuration input for the security configuration.
    tls_certificate_configuration: ?TLSCertificateConfiguration,

    pub const json_field_names = .{
        .tls_certificate_configuration = "tlsCertificateConfiguration",
    };
};
