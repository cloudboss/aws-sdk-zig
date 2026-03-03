const ResponseHeadersPolicyRemoveHeader = @import("response_headers_policy_remove_header.zig").ResponseHeadersPolicyRemoveHeader;

/// A list of HTTP header names that CloudFront removes from HTTP responses to
/// requests that match the cache behavior that this response headers policy is
/// attached to.
pub const ResponseHeadersPolicyRemoveHeadersConfig = struct {
    /// The list of HTTP header names.
    items: ?[]const ResponseHeadersPolicyRemoveHeader = null,

    /// The number of HTTP header names in the list.
    quantity: i32,
};
