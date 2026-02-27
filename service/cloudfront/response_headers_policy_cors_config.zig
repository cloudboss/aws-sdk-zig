const ResponseHeadersPolicyAccessControlAllowHeaders = @import("response_headers_policy_access_control_allow_headers.zig").ResponseHeadersPolicyAccessControlAllowHeaders;
const ResponseHeadersPolicyAccessControlAllowMethods = @import("response_headers_policy_access_control_allow_methods.zig").ResponseHeadersPolicyAccessControlAllowMethods;
const ResponseHeadersPolicyAccessControlAllowOrigins = @import("response_headers_policy_access_control_allow_origins.zig").ResponseHeadersPolicyAccessControlAllowOrigins;
const ResponseHeadersPolicyAccessControlExposeHeaders = @import("response_headers_policy_access_control_expose_headers.zig").ResponseHeadersPolicyAccessControlExposeHeaders;

/// A configuration for a set of HTTP response headers that are used for
/// cross-origin resource sharing (CORS). CloudFront adds these headers to HTTP
/// responses that it sends for CORS requests that match a cache behavior
/// associated with this response headers policy.
///
/// For more information about CORS, see [Cross-Origin Resource Sharing
/// (CORS)](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS) in the MDN
/// Web Docs.
pub const ResponseHeadersPolicyCorsConfig = struct {
    /// A Boolean that CloudFront uses as the value for the
    /// `Access-Control-Allow-Credentials` HTTP response header.
    ///
    /// For more information about the `Access-Control-Allow-Credentials` HTTP
    /// response header, see
    /// [Access-Control-Allow-Credentials](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Allow-Credentials) in the MDN Web Docs.
    access_control_allow_credentials: bool,

    /// A list of HTTP header names that CloudFront includes as values for the
    /// `Access-Control-Allow-Headers` HTTP response header.
    ///
    /// For more information about the `Access-Control-Allow-Headers` HTTP response
    /// header, see
    /// [Access-Control-Allow-Headers](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Allow-Headers) in the MDN Web Docs.
    access_control_allow_headers: ResponseHeadersPolicyAccessControlAllowHeaders,

    /// A list of HTTP methods that CloudFront includes as values for the
    /// `Access-Control-Allow-Methods` HTTP response header.
    ///
    /// For more information about the `Access-Control-Allow-Methods` HTTP response
    /// header, see
    /// [Access-Control-Allow-Methods](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Allow-Methods) in the MDN Web Docs.
    access_control_allow_methods: ResponseHeadersPolicyAccessControlAllowMethods,

    /// A list of origins (domain names) that CloudFront can use as the value for
    /// the `Access-Control-Allow-Origin` HTTP response header.
    ///
    /// For more information about the `Access-Control-Allow-Origin` HTTP response
    /// header, see
    /// [Access-Control-Allow-Origin](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Allow-Origin) in the MDN Web Docs.
    access_control_allow_origins: ResponseHeadersPolicyAccessControlAllowOrigins,

    /// A list of HTTP headers that CloudFront includes as values for the
    /// `Access-Control-Expose-Headers` HTTP response header.
    ///
    /// For more information about the `Access-Control-Expose-Headers` HTTP response
    /// header, see
    /// [Access-Control-Expose-Headers](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Expose-Headers) in the MDN Web Docs.
    access_control_expose_headers: ?ResponseHeadersPolicyAccessControlExposeHeaders,

    /// A number that CloudFront uses as the value for the `Access-Control-Max-Age`
    /// HTTP response header.
    ///
    /// For more information about the `Access-Control-Max-Age` HTTP response
    /// header, see
    /// [Access-Control-Max-Age](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Max-Age) in the MDN Web Docs.
    access_control_max_age_sec: ?i32,

    /// A Boolean that determines whether CloudFront overrides HTTP response headers
    /// received from the origin with the ones specified in this response headers
    /// policy.
    origin_override: bool,
};
