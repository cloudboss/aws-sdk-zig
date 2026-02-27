/// An HTTP response header name and its value. CloudFront includes this header
/// in HTTP responses that it sends for requests that match a cache behavior
/// that's associated with this response headers policy.
pub const ResponseHeadersPolicyCustomHeader = struct {
    /// The HTTP response header name.
    header: []const u8,

    /// A Boolean that determines whether CloudFront overrides a response header
    /// with the same name received from the origin with the header specified here.
    override: bool,

    /// The value for the HTTP response header.
    value: []const u8,
};
