/// Contains other options for the certificate.
pub const AwsCertificateManagerCertificateOptions = struct {
    /// Whether to add the certificate to a transparency log.
    ///
    /// Valid values: `DISABLED` | `ENABLED`
    certificate_transparency_logging_preference: ?[]const u8,

    pub const json_field_names = .{
        .certificate_transparency_logging_preference = "CertificateTransparencyLoggingPreference",
    };
};
