const ResponseHeadersPolicyConfig = @import("response_headers_policy_config.zig").ResponseHeadersPolicyConfig;

/// A response headers policy.
///
/// A response headers policy contains information about a set of HTTP response
/// headers.
///
/// After you create a response headers policy, you can use its ID to attach it
/// to one or more cache behaviors in a CloudFront distribution. When it's
/// attached to a cache behavior, the response headers policy affects the HTTP
/// headers that CloudFront includes in HTTP responses to requests that match
/// the cache behavior. CloudFront adds or removes response headers according to
/// the configuration of the response headers policy.
///
/// For more information, see [Adding or removing HTTP headers in CloudFront
/// responses](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/modifying-response-headers.html) in the *Amazon CloudFront Developer Guide*.
pub const ResponseHeadersPolicy = struct {
    /// The identifier for the response headers policy.
    id: []const u8,

    /// The date and time when the response headers policy was last modified.
    last_modified_time: i64,

    /// A response headers policy configuration.
    response_headers_policy_config: ResponseHeadersPolicyConfig,
};
