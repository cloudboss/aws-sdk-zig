const Aliases = @import("aliases.zig").Aliases;
const CacheBehaviors = @import("cache_behaviors.zig").CacheBehaviors;
const ConnectionFunctionAssociation = @import("connection_function_association.zig").ConnectionFunctionAssociation;
const ConnectionMode = @import("connection_mode.zig").ConnectionMode;
const CustomErrorResponses = @import("custom_error_responses.zig").CustomErrorResponses;
const DefaultCacheBehavior = @import("default_cache_behavior.zig").DefaultCacheBehavior;
const HttpVersion = @import("http_version.zig").HttpVersion;
const LoggingConfig = @import("logging_config.zig").LoggingConfig;
const OriginGroups = @import("origin_groups.zig").OriginGroups;
const Origins = @import("origins.zig").Origins;
const PriceClass = @import("price_class.zig").PriceClass;
const Restrictions = @import("restrictions.zig").Restrictions;
const TenantConfig = @import("tenant_config.zig").TenantConfig;
const ViewerCertificate = @import("viewer_certificate.zig").ViewerCertificate;
const ViewerMtlsConfig = @import("viewer_mtls_config.zig").ViewerMtlsConfig;

/// A distribution configuration.
pub const DistributionConfig = struct {
    /// This field only supports standard distributions. You can't specify this
    /// field for multi-tenant distributions. For more information, see [Unsupported
    /// features for SaaS Manager for Amazon
    /// CloudFront](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/distribution-config-options.html#unsupported-saas) in the *Amazon CloudFront Developer Guide*.
    ///
    /// A complex type that contains information about CNAMEs (alternate domain
    /// names), if any, for this distribution.
    aliases: ?Aliases,

    /// To use this field for a multi-tenant distribution, use a connection group
    /// instead. For more information, see
    /// [ConnectionGroup](https://docs.aws.amazon.com/cloudfront/latest/APIReference/API_ConnectionGroup.html).
    ///
    /// ID of the Anycast static IP list that is associated with the distribution.
    anycast_ip_list_id: ?[]const u8,

    /// A complex type that contains zero or more `CacheBehavior` elements.
    cache_behaviors: ?CacheBehaviors,

    /// A unique value (for example, a date-time stamp) that ensures that the
    /// request can't be replayed.
    ///
    /// If the value of `CallerReference` is new (regardless of the content of the
    /// `DistributionConfig` object), CloudFront creates a new distribution.
    ///
    /// If `CallerReference` is a value that you already sent in a previous request
    /// to create a distribution, CloudFront returns a `DistributionAlreadyExists`
    /// error.
    caller_reference: []const u8,

    /// A comment to describe the distribution. The comment cannot be longer than
    /// 128 characters.
    comment: []const u8,

    /// The distribution's connection function association.
    connection_function_association: ?ConnectionFunctionAssociation,

    /// This field specifies whether the connection mode is through a standard
    /// distribution (direct) or a multi-tenant distribution with distribution
    /// tenants (tenant-only).
    connection_mode: ?ConnectionMode,

    /// This field only supports standard distributions. You can't specify this
    /// field for multi-tenant distributions. For more information, see [Unsupported
    /// features for SaaS Manager for Amazon
    /// CloudFront](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/distribution-config-options.html#unsupported-saas) in the *Amazon CloudFront Developer Guide*.
    ///
    /// The identifier of a continuous deployment policy. For more information, see
    /// `CreateContinuousDeploymentPolicy`.
    continuous_deployment_policy_id: ?[]const u8,

    /// A complex type that controls the following:
    ///
    /// * Whether CloudFront replaces HTTP status codes in the 4xx and 5xx range
    ///   with custom error messages before returning the response to the viewer.
    /// * How long CloudFront caches HTTP status codes in the 4xx and 5xx range.
    ///
    /// For more information about custom error pages, see [Customizing Error
    /// Responses](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/custom-error-pages.html) in the *Amazon CloudFront Developer Guide*.
    custom_error_responses: ?CustomErrorResponses,

    /// A complex type that describes the default cache behavior if you don't
    /// specify a `CacheBehavior` element or if files don't match any of the values
    /// of `PathPattern` in `CacheBehavior` elements. You must create exactly one
    /// default cache behavior.
    default_cache_behavior: DefaultCacheBehavior,

    /// When a viewer requests the root URL for your distribution, the default root
    /// object is the object that you want CloudFront to request from your origin.
    /// For example, if your root URL is `https://www.example.com`, you can specify
    /// CloudFront to return the `index.html` file as the default root object. You
    /// can specify a default root object so that viewers see a specific file or
    /// object, instead of another object in your distribution (for example,
    /// `https://www.example.com/product-description.html`). A default root object
    /// avoids exposing the contents of your distribution.
    ///
    /// You can specify the object name or a path to the object name (for example,
    /// `index.html` or `exampleFolderName/index.html`). Your string can't begin
    /// with a forward slash (`/`). Only specify the object name or the path to the
    /// object.
    ///
    /// If you don't want to specify a default root object when you create a
    /// distribution, include an empty `DefaultRootObject` element.
    ///
    /// To delete the default root object from an existing distribution, update the
    /// distribution configuration and include an empty `DefaultRootObject` element.
    ///
    /// To replace the default root object, update the distribution configuration
    /// and specify the new object.
    ///
    /// For more information about the default root object, see [Specify a default
    /// root
    /// object](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/DefaultRootObject.html) in the *Amazon CloudFront Developer Guide*.
    default_root_object: ?[]const u8,

    /// From this field, you can enable or disable the selected distribution.
    enabled: bool,

    /// (Optional) Specify the HTTP version(s) that you want viewers to use to
    /// communicate with CloudFront. The default value for new web distributions is
    /// `http2`. Viewers that don't support HTTP/2 automatically use an earlier HTTP
    /// version.
    ///
    /// For viewers and CloudFront to use HTTP/2, viewers must support TLSv1.2 or
    /// later, and must support Server Name Indication (SNI).
    ///
    /// For viewers and CloudFront to use HTTP/3, viewers must support TLSv1.3 and
    /// Server Name Indication (SNI). CloudFront supports HTTP/3 connection
    /// migration to allow the viewer to switch networks without losing connection.
    /// For more information about connection migration, see [Connection
    /// Migration](https://www.rfc-editor.org/rfc/rfc9000.html#name-connection-migration) at RFC 9000. For more information about supported TLSv1.3 ciphers, see [Supported protocols and ciphers between viewers and CloudFront](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/secure-connections-supported-viewer-protocols-ciphers.html).
    http_version: ?HttpVersion,

    /// To use this field for a multi-tenant distribution, use a connection group
    /// instead. For more information, see
    /// [ConnectionGroup](https://docs.aws.amazon.com/cloudfront/latest/APIReference/API_ConnectionGroup.html).
    ///
    /// If you want CloudFront to respond to IPv6 DNS requests with an IPv6 address
    /// for your distribution, specify `true`. If you specify `false`, CloudFront
    /// responds to IPv6 DNS requests with the DNS response code `NOERROR` and with
    /// no IP addresses. This allows viewers to submit a second request, for an IPv4
    /// address for your distribution.
    ///
    /// In general, you should enable IPv6 if you have users on IPv6 networks who
    /// want to access your content. However, if you're using signed URLs or signed
    /// cookies to restrict access to your content, and if you're using a custom
    /// policy that includes the `IpAddress` parameter to restrict the IP addresses
    /// that can access your content, don't enable IPv6. If you want to restrict
    /// access to some content by IP address and not restrict access to other
    /// content (or restrict access but not by IP address), you can create two
    /// distributions. For more information, see [Creating a Signed URL Using a
    /// Custom
    /// Policy](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/private-content-creating-signed-url-custom-policy.html) in the *Amazon CloudFront Developer Guide*.
    ///
    /// If you're using an Route 53 Amazon Web Services Integration alias resource
    /// record set to route traffic to your CloudFront distribution, you need to
    /// create a second alias resource record set when both of the following are
    /// true:
    ///
    /// * You enable IPv6 for the distribution
    /// * You're using alternate domain names in the URLs for your objects
    ///
    /// For more information, see [Routing Traffic to an Amazon CloudFront Web
    /// Distribution by Using Your Domain
    /// Name](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/routing-to-cloudfront-distribution.html) in the *Route 53 Amazon Web Services Integration Developer Guide*.
    ///
    /// If you created a CNAME resource record set, either with Route 53 Amazon Web
    /// Services Integration or with another DNS service, you don't need to make any
    /// changes. A CNAME record will route traffic to your distribution regardless
    /// of the IP address format of the viewer request.
    is_ipv6_enabled: ?bool,

    /// A complex type that controls whether access logs are written for the
    /// distribution.
    ///
    /// For more information about logging, see [Access
    /// Logs](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/AccessLogs.html) in the *Amazon CloudFront Developer Guide*.
    logging: ?LoggingConfig,

    /// A complex type that contains information about origin groups for this
    /// distribution.
    origin_groups: ?OriginGroups,

    /// A complex type that contains information about origins for this
    /// distribution.
    origins: Origins,

    /// This field only supports standard distributions. You can't specify this
    /// field for multi-tenant distributions. For more information, see [Unsupported
    /// features for SaaS Manager for Amazon
    /// CloudFront](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/distribution-config-options.html#unsupported-saas) in the *Amazon CloudFront Developer Guide*.
    ///
    /// The price class that corresponds with the maximum price that you want to pay
    /// for CloudFront service. If you specify `PriceClass_All`, CloudFront responds
    /// to requests for your objects from all CloudFront edge locations.
    ///
    /// If you specify a price class other than `PriceClass_All`, CloudFront serves
    /// your objects from the CloudFront edge location that has the lowest latency
    /// among the edge locations in your price class. Viewers who are in or near
    /// regions that are excluded from your specified price class may encounter
    /// slower performance.
    ///
    /// For more information about price classes, see [Choosing the Price Class for
    /// a CloudFront
    /// Distribution](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/PriceClass.html) in the *Amazon CloudFront Developer Guide*. For information about CloudFront pricing, including how price classes (such as Price Class 100) map to CloudFront regions, see [Amazon CloudFront Pricing](http://aws.amazon.com/cloudfront/pricing/).
    price_class: ?PriceClass,

    /// A complex type that identifies ways in which you want to restrict
    /// distribution of your content.
    restrictions: ?Restrictions,

    /// This field only supports standard distributions. You can't specify this
    /// field for multi-tenant distributions. For more information, see [Unsupported
    /// features for SaaS Manager for Amazon
    /// CloudFront](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/distribution-config-options.html#unsupported-saas) in the *Amazon CloudFront Developer Guide*.
    ///
    /// A Boolean that indicates whether this is a staging distribution. When this
    /// value is `true`, this is a staging distribution. When this value is `false`,
    /// this is not a staging distribution.
    staging: ?bool,

    /// This field only supports multi-tenant distributions. You can't specify this
    /// field for standard distributions. For more information, see [Unsupported
    /// features for SaaS Manager for Amazon
    /// CloudFront](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/distribution-config-options.html#unsupported-saas) in the *Amazon CloudFront Developer Guide*.
    ///
    /// A distribution tenant configuration.
    tenant_config: ?TenantConfig,

    /// A complex type that determines the distribution's SSL/TLS configuration for
    /// communicating with viewers.
    viewer_certificate: ?ViewerCertificate,

    /// The distribution's viewer mTLS configuration.
    viewer_mtls_config: ?ViewerMtlsConfig,

    /// Multi-tenant distributions only support WAF V2 web ACLs.
    ///
    /// A unique identifier that specifies the WAF web ACL, if any, to associate
    /// with this distribution. To specify a web ACL created using the latest
    /// version of WAF, use the ACL ARN, for example
    /// `arn:aws:wafv2:us-east-1:123456789012:global/webacl/ExampleWebACL/a1b2c3d4-5678-90ab-cdef-EXAMPLE11111`. To specify a web ACL created using WAF Classic, use the ACL ID, for example `a1b2c3d4-5678-90ab-cdef-EXAMPLE11111`.
    ///
    /// WAF is a web application firewall that lets you monitor the HTTP and HTTPS
    /// requests that are forwarded to CloudFront, and lets you control access to
    /// your content. Based on conditions that you specify, such as the IP addresses
    /// that requests originate from or the values of query strings, CloudFront
    /// responds to requests either with the requested content or with an HTTP 403
    /// status code (Forbidden). You can also configure CloudFront to return a
    /// custom error page when a request is blocked. For more information about WAF,
    /// see the [WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/what-is-aws-waf.html).
    web_acl_id: ?[]const u8,
};
