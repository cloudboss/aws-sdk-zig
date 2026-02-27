const ResponseHeadersPolicyCustomHeader = @import("response_headers_policy_custom_header.zig").ResponseHeadersPolicyCustomHeader;

/// A list of HTTP response header names and their values. CloudFront includes
/// these headers in HTTP responses that it sends for requests that match a
/// cache behavior that's associated with this response headers policy.
pub const ResponseHeadersPolicyCustomHeadersConfig = struct {
    /// The list of HTTP response headers and their values.
    items: ?[]const ResponseHeadersPolicyCustomHeader,

    /// The number of HTTP response headers in the list.
    quantity: i32,
};
