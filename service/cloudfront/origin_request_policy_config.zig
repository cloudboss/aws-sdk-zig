const OriginRequestPolicyCookiesConfig = @import("origin_request_policy_cookies_config.zig").OriginRequestPolicyCookiesConfig;
const OriginRequestPolicyHeadersConfig = @import("origin_request_policy_headers_config.zig").OriginRequestPolicyHeadersConfig;
const OriginRequestPolicyQueryStringsConfig = @import("origin_request_policy_query_strings_config.zig").OriginRequestPolicyQueryStringsConfig;

/// An origin request policy configuration.
///
/// This configuration determines the values that CloudFront includes in
/// requests that it sends to the origin. Each request that CloudFront sends to
/// the origin includes the following:
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
pub const OriginRequestPolicyConfig = struct {
    /// A comment to describe the origin request policy. The comment cannot be
    /// longer than 128 characters.
    comment: ?[]const u8 = null,

    /// The cookies from viewer requests to include in origin requests.
    cookies_config: OriginRequestPolicyCookiesConfig,

    /// The HTTP headers to include in origin requests. These can include headers
    /// from viewer requests and additional headers added by CloudFront.
    headers_config: OriginRequestPolicyHeadersConfig,

    /// A unique name to identify the origin request policy.
    name: []const u8,

    /// The URL query strings from viewer requests to include in origin requests.
    query_strings_config: OriginRequestPolicyQueryStringsConfig,
};
