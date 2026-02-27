const CacheBehaviorPerPath = @import("cache_behavior_per_path.zig").CacheBehaviorPerPath;
const CacheSettings = @import("cache_settings.zig").CacheSettings;
const CacheBehavior = @import("cache_behavior.zig").CacheBehavior;
const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const ResourceLocation = @import("resource_location.zig").ResourceLocation;
const Origin = @import("origin.zig").Origin;
const ResourceType = @import("resource_type.zig").ResourceType;
const Tag = @import("tag.zig").Tag;

/// Describes an Amazon Lightsail content delivery network (CDN) distribution.
pub const LightsailDistribution = struct {
    /// Indicates whether the bundle that is currently applied to your distribution,
    /// specified
    /// using the `distributionName` parameter, can be changed to another bundle.
    ///
    /// Use the `UpdateDistributionBundle` action to change your distribution's
    /// bundle.
    able_to_update_bundle: ?bool,

    /// The alternate domain names of the distribution.
    alternative_domain_names: ?[]const []const u8,

    /// The Amazon Resource Name (ARN) of the distribution.
    arn: ?[]const u8,

    /// The ID of the bundle currently applied to the distribution.
    bundle_id: ?[]const u8,

    /// An array of objects that describe the per-path cache behavior of the
    /// distribution.
    cache_behaviors: ?[]const CacheBehaviorPerPath,

    /// An object that describes the cache behavior settings of the distribution.
    cache_behavior_settings: ?CacheSettings,

    /// The name of the SSL/TLS certificate attached to the distribution, if any.
    certificate_name: ?[]const u8,

    /// The timestamp when the distribution was created.
    created_at: ?i64,

    /// An object that describes the default cache behavior of the distribution.
    default_cache_behavior: ?CacheBehavior,

    /// The domain name of the distribution.
    domain_name: ?[]const u8,

    /// The IP address type of the distribution.
    ///
    /// The possible values are `ipv4` for IPv4 only, and `dualstack` for
    /// IPv4 and IPv6.
    ip_address_type: ?IpAddressType,

    /// Indicates whether the distribution is enabled.
    is_enabled: ?bool,

    /// An object that describes the location of the distribution, such as the
    /// Amazon Web Services
    /// Region and Availability Zone.
    ///
    /// Lightsail distributions are global resources that can reference an origin in
    /// any
    /// Amazon Web Services Region, and distribute its content globally. However,
    /// all distributions
    /// are located in the `us-east-1` Region.
    location: ?ResourceLocation,

    /// The name of the distribution.
    name: ?[]const u8,

    /// An object that describes the origin resource of the distribution, such as a
    /// Lightsail
    /// instance, bucket, or load balancer.
    ///
    /// The distribution pulls, caches, and serves content from the origin.
    origin: ?Origin,

    /// The public DNS of the origin.
    origin_public_dns: ?[]const u8,

    /// The Lightsail resource type (`Distribution`).
    resource_type: ?ResourceType,

    /// The status of the distribution.
    status: ?[]const u8,

    /// The support code. Include this code in your email to support when you have
    /// questions about
    /// your Lightsail distribution. This code enables our support team to look up
    /// your Lightsail
    /// information more easily.
    support_code: ?[]const u8,

    /// The tag keys and optional values for the resource. For more information
    /// about tags in
    /// Lightsail, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-tags).
    tags: ?[]const Tag,

    /// The minimum TLS protocol version that the distribution can use to
    /// communicate with
    /// viewers.
    viewer_minimum_tls_protocol_version: ?[]const u8,

    pub const json_field_names = .{
        .able_to_update_bundle = "ableToUpdateBundle",
        .alternative_domain_names = "alternativeDomainNames",
        .arn = "arn",
        .bundle_id = "bundleId",
        .cache_behaviors = "cacheBehaviors",
        .cache_behavior_settings = "cacheBehaviorSettings",
        .certificate_name = "certificateName",
        .created_at = "createdAt",
        .default_cache_behavior = "defaultCacheBehavior",
        .domain_name = "domainName",
        .ip_address_type = "ipAddressType",
        .is_enabled = "isEnabled",
        .location = "location",
        .name = "name",
        .origin = "origin",
        .origin_public_dns = "originPublicDNS",
        .resource_type = "resourceType",
        .status = "status",
        .support_code = "supportCode",
        .tags = "tags",
        .viewer_minimum_tls_protocol_version = "viewerMinimumTlsProtocolVersion",
    };
};
