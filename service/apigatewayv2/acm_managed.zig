/// Represents a domain name and certificate for a portal.
pub const ACMManaged = struct {
    /// The certificate ARN.
    certificate_arn: []const u8,

    /// The domain name.
    domain_name: []const u8,

    pub const json_field_names = .{
        .certificate_arn = "CertificateArn",
        .domain_name = "DomainName",
    };
};
