/// A complex type that specifies the HTTP header name from which CloudFront
/// extracts cache tags from origin responses. When you add `CacheTagConfig` to
/// a distribution, CloudFront reads the specified header from origin responses,
/// parses the comma-separated tag values, and stores them with the cached
/// object. You can then invalidate cached objects by tag using the
/// `CreateInvalidation` API.
pub const CacheTagConfig = struct {
    /// The name of the HTTP header that your origin includes in responses.
    /// CloudFront uses this header to extract cache tags. The header value must
    /// contain comma-separated tag values (for example, `product:electronics,
    /// category:tv, brand:example`).
    header_name: []const u8,
};
