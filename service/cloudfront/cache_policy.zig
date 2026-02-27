const CachePolicyConfig = @import("cache_policy_config.zig").CachePolicyConfig;

/// A cache policy.
///
/// When it's attached to a cache behavior, the cache policy determines the
/// following:
///
/// * The values that CloudFront includes in the cache key. These values can
///   include HTTP headers, cookies, and URL query strings. CloudFront uses the
///   cache key to find an object in its cache that it can return to the viewer.
/// * The default, minimum, and maximum time to live (TTL) values that you want
///   objects to stay in the CloudFront cache.
///
/// The headers, cookies, and query strings that are included in the cache key
/// are also included in requests that CloudFront sends to the origin.
/// CloudFront sends a request when it can't find a valid object in its cache
/// that matches the request's cache key. If you want to send values to the
/// origin but *not* include them in the cache key, use `OriginRequestPolicy`.
pub const CachePolicy = struct {
    /// The cache policy configuration.
    cache_policy_config: CachePolicyConfig,

    /// The unique identifier for the cache policy.
    id: []const u8,

    /// The date and time when the cache policy was last modified.
    last_modified_time: i64,
};
