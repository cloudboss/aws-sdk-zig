const OriginRequestPolicyHeaderBehavior = @import("origin_request_policy_header_behavior.zig").OriginRequestPolicyHeaderBehavior;
const Headers = @import("headers.zig").Headers;

/// An object that determines whether any HTTP headers (and if so, which
/// headers) are included in requests that CloudFront sends to the origin.
pub const OriginRequestPolicyHeadersConfig = struct {
    /// Determines whether any HTTP headers are included in requests that CloudFront
    /// sends to the origin. Valid values are:
    ///
    /// * `none` – No HTTP headers in viewer requests are included in requests that
    ///   CloudFront sends to the origin. Even when this field is set to `none`, any
    ///   headers that are listed in a `CachePolicy` *are* included in origin
    ///   requests.
    /// * `whitelist` – Only the HTTP headers that are listed in the `Headers` type
    ///   are included in requests that CloudFront sends to the origin.
    /// * `allViewer` – All HTTP headers in viewer requests are included in requests
    ///   that CloudFront sends to the origin.
    /// * `allViewerAndWhitelistCloudFront` – All HTTP headers in viewer requests
    ///   and the additional CloudFront headers that are listed in the `Headers`
    ///   type are included in requests that CloudFront sends to the origin. The
    ///   additional headers are added by CloudFront.
    /// * `allExcept` – All HTTP headers in viewer requests are included in requests
    ///   that CloudFront sends to the origin, * **except** * for those listed in
    ///   the `Headers` type, which are not included.
    header_behavior: OriginRequestPolicyHeaderBehavior,

    headers: ?Headers,
};
