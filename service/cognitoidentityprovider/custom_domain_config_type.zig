/// The configuration for a hosted UI custom domain.
pub const CustomDomainConfigType = struct {
    /// The Amazon Resource Name (ARN) of an Certificate Manager SSL certificate.
    /// You use
    /// this certificate for the subdomain of your custom domain.
    certificate_arn: []const u8,

    pub const json_field_names = .{
        .certificate_arn = "CertificateArn",
    };
};
