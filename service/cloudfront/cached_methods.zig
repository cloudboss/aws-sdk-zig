const Method = @import("method.zig").Method;

/// A complex type that controls whether CloudFront caches the response to
/// requests using the specified HTTP methods. There are two choices:
///
/// * CloudFront caches responses to `GET` and `HEAD` requests.
/// * CloudFront caches responses to `GET`, `HEAD`, and `OPTIONS` requests.
///
/// If you pick the second choice for your Amazon S3 Origin, you may need to
/// forward Access-Control-Request-Method, Access-Control-Request-Headers, and
/// Origin headers for the responses to be cached correctly.
pub const CachedMethods = struct {
    /// A complex type that contains the HTTP methods that you want CloudFront to
    /// cache responses to. Valid values for `CachedMethods` include `GET`, `HEAD`,
    /// and `OPTIONS`, depending on which caching option you choose. For more
    /// information, see the preceding section.
    items: []const Method,

    /// The number of HTTP methods for which you want CloudFront to cache responses.
    /// Valid values are `2` (for caching responses to `GET` and `HEAD` requests)
    /// and `3` (for caching responses to `GET`, `HEAD`, and `OPTIONS` requests).
    quantity: i32,
};
