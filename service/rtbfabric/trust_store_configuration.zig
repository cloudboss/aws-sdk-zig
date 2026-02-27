/// Describes the configuration of a trust store.
pub const TrustStoreConfiguration = struct {
    /// The certificate authority certificate.
    certificate_authority_certificates: []const []const u8,

    pub const json_field_names = .{
        .certificate_authority_certificates = "certificateAuthorityCertificates",
    };
};
