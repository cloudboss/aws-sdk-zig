const ResponseHeadersPolicyContentSecurityPolicy = @import("response_headers_policy_content_security_policy.zig").ResponseHeadersPolicyContentSecurityPolicy;
const ResponseHeadersPolicyContentTypeOptions = @import("response_headers_policy_content_type_options.zig").ResponseHeadersPolicyContentTypeOptions;
const ResponseHeadersPolicyFrameOptions = @import("response_headers_policy_frame_options.zig").ResponseHeadersPolicyFrameOptions;
const ResponseHeadersPolicyReferrerPolicy = @import("response_headers_policy_referrer_policy.zig").ResponseHeadersPolicyReferrerPolicy;
const ResponseHeadersPolicyStrictTransportSecurity = @import("response_headers_policy_strict_transport_security.zig").ResponseHeadersPolicyStrictTransportSecurity;
const ResponseHeadersPolicyXSSProtection = @import("response_headers_policy_xss_protection.zig").ResponseHeadersPolicyXSSProtection;

/// A configuration for a set of security-related HTTP response headers.
/// CloudFront adds these headers to HTTP responses that it sends for requests
/// that match a cache behavior associated with this response headers policy.
pub const ResponseHeadersPolicySecurityHeadersConfig = struct {
    /// The policy directives and their values that CloudFront includes as values
    /// for the `Content-Security-Policy` HTTP response header.
    ///
    /// For more information about the `Content-Security-Policy` HTTP response
    /// header, see
    /// [Content-Security-Policy](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy) in the MDN Web Docs.
    content_security_policy: ?ResponseHeadersPolicyContentSecurityPolicy = null,

    /// Determines whether CloudFront includes the `X-Content-Type-Options` HTTP
    /// response header with its value set to `nosniff`.
    ///
    /// For more information about the `X-Content-Type-Options` HTTP response
    /// header, see
    /// [X-Content-Type-Options](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Content-Type-Options) in the MDN Web Docs.
    content_type_options: ?ResponseHeadersPolicyContentTypeOptions = null,

    /// Determines whether CloudFront includes the `X-Frame-Options` HTTP response
    /// header and the header's value.
    ///
    /// For more information about the `X-Frame-Options` HTTP response header, see
    /// [X-Frame-Options](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Frame-Options) in the MDN Web Docs.
    frame_options: ?ResponseHeadersPolicyFrameOptions = null,

    /// Determines whether CloudFront includes the `Referrer-Policy` HTTP response
    /// header and the header's value.
    ///
    /// For more information about the `Referrer-Policy` HTTP response header, see
    /// [Referrer-Policy](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Referrer-Policy) in the MDN Web Docs.
    referrer_policy: ?ResponseHeadersPolicyReferrerPolicy = null,

    /// Determines whether CloudFront includes the `Strict-Transport-Security` HTTP
    /// response header and the header's value.
    ///
    /// For more information about the `Strict-Transport-Security` HTTP response
    /// header, see [Security
    /// headers](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/understanding-response-headers-policies.html#understanding-response-headers-policies-security) in the *Amazon CloudFront Developer Guide* and [Strict-Transport-Security](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Strict-Transport-Security) in the MDN Web Docs.
    strict_transport_security: ?ResponseHeadersPolicyStrictTransportSecurity = null,

    /// Determines whether CloudFront includes the `X-XSS-Protection` HTTP response
    /// header and the header's value.
    ///
    /// For more information about the `X-XSS-Protection` HTTP response header, see
    /// [X-XSS-Protection](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-XSS-Protection) in the MDN Web Docs.
    xss_protection: ?ResponseHeadersPolicyXSSProtection = null,
};
