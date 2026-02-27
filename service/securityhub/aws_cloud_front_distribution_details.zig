const AwsCloudFrontDistributionCacheBehaviors = @import("aws_cloud_front_distribution_cache_behaviors.zig").AwsCloudFrontDistributionCacheBehaviors;
const AwsCloudFrontDistributionDefaultCacheBehavior = @import("aws_cloud_front_distribution_default_cache_behavior.zig").AwsCloudFrontDistributionDefaultCacheBehavior;
const AwsCloudFrontDistributionLogging = @import("aws_cloud_front_distribution_logging.zig").AwsCloudFrontDistributionLogging;
const AwsCloudFrontDistributionOriginGroups = @import("aws_cloud_front_distribution_origin_groups.zig").AwsCloudFrontDistributionOriginGroups;
const AwsCloudFrontDistributionOrigins = @import("aws_cloud_front_distribution_origins.zig").AwsCloudFrontDistributionOrigins;
const AwsCloudFrontDistributionViewerCertificate = @import("aws_cloud_front_distribution_viewer_certificate.zig").AwsCloudFrontDistributionViewerCertificate;

/// A CloudFront distribution configuration.
pub const AwsCloudFrontDistributionDetails = struct {
    /// Provides information about the cache configuration for the distribution.
    cache_behaviors: ?AwsCloudFrontDistributionCacheBehaviors,

    /// The default cache behavior for the configuration.
    default_cache_behavior: ?AwsCloudFrontDistributionDefaultCacheBehavior,

    /// The object that CloudFront sends in response to requests from the origin
    /// (for example,
    /// index.html) when a viewer requests the root URL for the distribution
    /// (http://www.example.com) instead of an object in your distribution
    /// (http://www.example.com/product-description.html).
    default_root_object: ?[]const u8,

    /// The domain name corresponding to the distribution.
    domain_name: ?[]const u8,

    /// The entity tag is a hash of the object.
    e_tag: ?[]const u8,

    /// Indicates when that the distribution was last modified.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    last_modified_time: ?[]const u8,

    /// A complex type that controls whether access logs are written for the
    /// distribution.
    logging: ?AwsCloudFrontDistributionLogging,

    /// Provides information about the origin groups in the distribution.
    origin_groups: ?AwsCloudFrontDistributionOriginGroups,

    /// A complex type that contains information about origins for this
    /// distribution.
    origins: ?AwsCloudFrontDistributionOrigins,

    /// Indicates the current status of the distribution.
    status: ?[]const u8,

    /// Provides information about the TLS/SSL configuration that the distribution
    /// uses to communicate with viewers.
    viewer_certificate: ?AwsCloudFrontDistributionViewerCertificate,

    /// A unique identifier that specifies the WAF web ACL, if any, to associate
    /// with this distribution.
    web_acl_id: ?[]const u8,

    pub const json_field_names = .{
        .cache_behaviors = "CacheBehaviors",
        .default_cache_behavior = "DefaultCacheBehavior",
        .default_root_object = "DefaultRootObject",
        .domain_name = "DomainName",
        .e_tag = "ETag",
        .last_modified_time = "LastModifiedTime",
        .logging = "Logging",
        .origin_groups = "OriginGroups",
        .origins = "Origins",
        .status = "Status",
        .viewer_certificate = "ViewerCertificate",
        .web_acl_id = "WebAclId",
    };
};
