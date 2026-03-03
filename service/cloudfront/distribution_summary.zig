const Aliases = @import("aliases.zig").Aliases;
const AliasICPRecordal = @import("alias_icp_recordal.zig").AliasICPRecordal;
const CacheBehaviors = @import("cache_behaviors.zig").CacheBehaviors;
const ConnectionFunctionAssociation = @import("connection_function_association.zig").ConnectionFunctionAssociation;
const ConnectionMode = @import("connection_mode.zig").ConnectionMode;
const CustomErrorResponses = @import("custom_error_responses.zig").CustomErrorResponses;
const DefaultCacheBehavior = @import("default_cache_behavior.zig").DefaultCacheBehavior;
const HttpVersion = @import("http_version.zig").HttpVersion;
const OriginGroups = @import("origin_groups.zig").OriginGroups;
const Origins = @import("origins.zig").Origins;
const PriceClass = @import("price_class.zig").PriceClass;
const Restrictions = @import("restrictions.zig").Restrictions;
const ViewerCertificate = @import("viewer_certificate.zig").ViewerCertificate;
const ViewerMtlsConfig = @import("viewer_mtls_config.zig").ViewerMtlsConfig;

/// A summary of the information about a CloudFront distribution.
pub const DistributionSummary = struct {
    /// A complex type that contains information about CNAMEs (alternate domain
    /// names), if any, for this distribution.
    aliases: Aliases,

    /// Amazon Web Services services in China customers must file for an Internet
    /// Content Provider (ICP) recordal if they want to serve content publicly on an
    /// alternate domain name, also known as a CNAME, that they've added to
    /// CloudFront. AliasICPRecordal provides the ICP recordal status for CNAMEs
    /// associated with distributions.
    ///
    /// For more information about ICP recordals, see [ Signup, Accounts, and
    /// Credentials](https://docs.amazonaws.cn/en_us/aws/latest/userguide/accounts-and-credentials.html) in *Getting Started with Amazon Web Services services in China*.
    alias_icp_recordals: ?[]const AliasICPRecordal = null,

    /// ID of the Anycast static IP list that is associated with the distribution.
    anycast_ip_list_id: ?[]const u8 = null,

    /// The ARN (Amazon Resource Name) for the distribution. For example:
    /// `arn:aws:cloudfront::123456789012:distribution/EDFDVBD632BHDS5`, where
    /// `123456789012` is your Amazon Web Services account ID.
    arn: []const u8,

    /// A complex type that contains zero or more `CacheBehavior` elements.
    cache_behaviors: CacheBehaviors,

    /// The comment originally specified when this distribution was created.
    comment: []const u8,

    /// The distribution's connection function association.
    connection_function_association: ?ConnectionFunctionAssociation = null,

    /// This field specifies whether the connection mode is through a standard
    /// distribution (direct) or a multi-tenant distribution with distribution
    /// tenants (tenant-only).
    connection_mode: ?ConnectionMode = null,

    /// A complex type that contains zero or more `CustomErrorResponses` elements.
    custom_error_responses: CustomErrorResponses,

    /// A complex type that describes the default cache behavior if you don't
    /// specify a `CacheBehavior` element or if files don't match any of the values
    /// of `PathPattern` in `CacheBehavior` elements. You must create exactly one
    /// default cache behavior.
    default_cache_behavior: DefaultCacheBehavior,

    /// The domain name that corresponds to the distribution, for example,
    /// `d111111abcdef8.cloudfront.net`.
    domain_name: []const u8,

    /// Whether the distribution is enabled to accept user requests for content.
    enabled: bool,

    /// The current version of the distribution.
    e_tag: ?[]const u8 = null,

    /// Specify the maximum HTTP version that you want viewers to use to communicate
    /// with CloudFront. The default value for new web distributions is `http2`.
    /// Viewers that don't support `HTTP/2` will automatically use an earlier
    /// version.
    http_version: HttpVersion,

    /// The identifier for the distribution. For example: `EDFDVBD632BHDS5`.
    id: []const u8,

    /// Whether CloudFront responds to IPv6 DNS requests with an IPv6 address for
    /// your distribution.
    is_ipv6_enabled: bool,

    /// The date and time the distribution was last modified.
    last_modified_time: i64,

    /// A complex type that contains information about origin groups for this
    /// distribution.
    origin_groups: ?OriginGroups = null,

    /// A complex type that contains information about origins for this
    /// distribution.
    origins: Origins,

    /// This field only supports standard distributions. You can't specify this
    /// field for multi-tenant distributions. For more information, see [Unsupported
    /// features for SaaS Manager for Amazon
    /// CloudFront](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/distribution-config-options.html#unsupported-saas) in the *Amazon CloudFront Developer Guide*.
    ///
    /// A complex type that contains information about price class for this
    /// streaming distribution.
    price_class: PriceClass,

    /// A complex type that identifies ways in which you want to restrict
    /// distribution of your content.
    restrictions: Restrictions,

    /// A Boolean that indicates whether this is a staging distribution. When this
    /// value is `true`, this is a staging distribution. When this value is `false`,
    /// this is not a staging distribution.
    staging: bool,

    /// The current status of the distribution. When the status is `Deployed`, the
    /// distribution's information is propagated to all CloudFront edge locations.
    status: []const u8,

    /// A complex type that determines the distribution's SSL/TLS configuration for
    /// communicating with viewers.
    viewer_certificate: ViewerCertificate,

    /// The distribution's viewer mTLS configuration.
    viewer_mtls_config: ?ViewerMtlsConfig = null,

    /// The Web ACL Id (if any) associated with the distribution.
    web_acl_id: []const u8,
};
