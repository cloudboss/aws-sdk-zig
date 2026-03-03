const aws = @import("aws");

/// Describes a configuration for a custom domain.
pub const DomainNameConfig = struct {
    /// The domain name that AppSync provides.
    appsync_domain_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the certificate. This can be an
    /// Certificate Manager
    /// (ACM) certificate or an Identity and Access Management (IAM)
    /// server certificate.
    certificate_arn: ?[]const u8 = null,

    /// A description of the `DomainName` configuration.
    description: ?[]const u8 = null,

    /// The domain name.
    domain_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the domain name.
    domain_name_arn: ?[]const u8 = null,

    /// The ID of your Amazon Route 53 hosted zone.
    hosted_zone_id: ?[]const u8 = null,

    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .appsync_domain_name = "appsyncDomainName",
        .certificate_arn = "certificateArn",
        .description = "description",
        .domain_name = "domainName",
        .domain_name_arn = "domainNameArn",
        .hosted_zone_id = "hostedZoneId",
        .tags = "tags",
    };
};
