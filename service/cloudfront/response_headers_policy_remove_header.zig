/// The name of an HTTP header that CloudFront removes from HTTP responses to
/// requests that match the cache behavior that this response headers policy is
/// attached to.
pub const ResponseHeadersPolicyRemoveHeader = struct {
    /// The HTTP header name.
    header: []const u8,
};
