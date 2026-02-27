const ResponseHeadersPolicyCorsConfig = @import("response_headers_policy_cors_config.zig").ResponseHeadersPolicyCorsConfig;
const ResponseHeadersPolicyCustomHeadersConfig = @import("response_headers_policy_custom_headers_config.zig").ResponseHeadersPolicyCustomHeadersConfig;
const ResponseHeadersPolicyRemoveHeadersConfig = @import("response_headers_policy_remove_headers_config.zig").ResponseHeadersPolicyRemoveHeadersConfig;
const ResponseHeadersPolicySecurityHeadersConfig = @import("response_headers_policy_security_headers_config.zig").ResponseHeadersPolicySecurityHeadersConfig;
const ResponseHeadersPolicyServerTimingHeadersConfig = @import("response_headers_policy_server_timing_headers_config.zig").ResponseHeadersPolicyServerTimingHeadersConfig;

/// A response headers policy configuration.
///
/// A response headers policy configuration contains metadata about the response
/// headers policy, and configurations for sets of HTTP response headers.
pub const ResponseHeadersPolicyConfig = struct {
    /// A comment to describe the response headers policy.
    ///
    /// The comment cannot be longer than 128 characters.
    comment: ?[]const u8,

    /// A configuration for a set of HTTP response headers that are used for
    /// cross-origin resource sharing (CORS).
    cors_config: ?ResponseHeadersPolicyCorsConfig,

    /// A configuration for a set of custom HTTP response headers.
    custom_headers_config: ?ResponseHeadersPolicyCustomHeadersConfig,

    /// A name to identify the response headers policy.
    ///
    /// The name must be unique for response headers policies in this Amazon Web
    /// Services account.
    name: []const u8,

    /// A configuration for a set of HTTP headers to remove from the HTTP response.
    remove_headers_config: ?ResponseHeadersPolicyRemoveHeadersConfig,

    /// A configuration for a set of security-related HTTP response headers.
    security_headers_config: ?ResponseHeadersPolicySecurityHeadersConfig,

    /// A configuration for enabling the `Server-Timing` header in HTTP responses
    /// sent from CloudFront.
    server_timing_headers_config: ?ResponseHeadersPolicyServerTimingHeadersConfig,
};
