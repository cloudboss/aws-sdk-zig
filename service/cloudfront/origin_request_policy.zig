const OriginRequestPolicyConfig = @import("origin_request_policy_config.zig").OriginRequestPolicyConfig;

/// An origin request policy.
///
/// When it's attached to a cache behavior, the origin request policy determines
/// the values that CloudFront includes in requests that it sends to the origin.
/// Each request that CloudFront sends to the origin includes the following:
///
/// * The request body and the URL path (without the domain name) from the
///   viewer request.
/// * The headers that CloudFront automatically includes in every origin
///   request, including `Host`, `User-Agent`, and `X-Amz-Cf-Id`.
/// * All HTTP headers, cookies, and URL query strings that are specified in the
///   cache policy or the origin request policy. These can include items from
///   the viewer request and, in the case of headers, additional ones that are
///   added by CloudFront.
///
/// CloudFront sends a request when it can't find an object in its cache that
/// matches the request. If you want to send values to the origin and also
/// include them in the cache key, use `CachePolicy`.
pub const OriginRequestPolicy = struct {
    /// The unique identifier for the origin request policy.
    id: []const u8,

    /// The date and time when the origin request policy was last modified.
    last_modified_time: i64,

    /// The origin request policy configuration.
    origin_request_policy_config: OriginRequestPolicyConfig,
};
