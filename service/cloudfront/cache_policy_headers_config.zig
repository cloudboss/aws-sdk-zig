const CachePolicyHeaderBehavior = @import("cache_policy_header_behavior.zig").CachePolicyHeaderBehavior;
const Headers = @import("headers.zig").Headers;

/// An object that determines whether any HTTP headers (and if so, which
/// headers) are included in the cache key and in requests that CloudFront sends
/// to the origin.
pub const CachePolicyHeadersConfig = struct {
    /// Determines whether any HTTP headers are included in the cache key and in
    /// requests that CloudFront sends to the origin. Valid values are:
    ///
    /// * `none` – No HTTP headers are included in the cache key or in requests that
    ///   CloudFront sends to the origin. Even when this field is set to `none`, any
    ///   headers that are listed in an `OriginRequestPolicy` *are* included in
    ///   origin requests.
    /// * `whitelist` – Only the HTTP headers that are listed in the `Headers` type
    ///   are included in the cache key and in requests that CloudFront sends to the
    ///   origin.
    header_behavior: CachePolicyHeaderBehavior,

    headers: ?Headers,
};
