/// Represents an endpoint configuration.
pub const EndpointConfigurationResponse = struct {
    /// The ARN of the ACM certificate.
    certificate_arn: ?[]const u8,

    /// The domain name.
    domain_name: ?[]const u8,

    /// The portal default domain name. This domain name is generated and managed by
    /// API Gateway.
    portal_default_domain_name: []const u8,

    /// The portal domain hosted zone identifier.
    portal_domain_hosted_zone_id: []const u8,

    pub const json_field_names = .{
        .certificate_arn = "CertificateArn",
        .domain_name = "DomainName",
        .portal_default_domain_name = "PortalDefaultDomainName",
        .portal_domain_hosted_zone_id = "PortalDomainHostedZoneId",
    };
};
