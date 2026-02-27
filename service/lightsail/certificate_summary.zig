const Certificate = @import("certificate.zig").Certificate;
const Tag = @import("tag.zig").Tag;

/// Describes an Amazon Lightsail SSL/TLS certificate.
pub const CertificateSummary = struct {
    /// The Amazon Resource Name (ARN) of the certificate.
    certificate_arn: ?[]const u8,

    /// An object that describes a certificate in detail.
    certificate_detail: ?Certificate,

    /// The name of the certificate.
    certificate_name: ?[]const u8,

    /// The domain name of the certificate.
    domain_name: ?[]const u8,

    /// The tag keys and optional values for the resource. For more information
    /// about tags in
    /// Lightsail, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-tags).
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .certificate_arn = "certificateArn",
        .certificate_detail = "certificateDetail",
        .certificate_name = "certificateName",
        .domain_name = "domainName",
        .tags = "tags",
    };
};
