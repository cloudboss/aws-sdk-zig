/// The certificate provider summary.
pub const CertificateProviderSummary = struct {
    /// The ARN of the certificate provider.
    certificate_provider_arn: ?[]const u8 = null,

    /// The name of the certificate provider.
    certificate_provider_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .certificate_provider_arn = "certificateProviderArn",
        .certificate_provider_name = "certificateProviderName",
    };
};
