/// The optional response-caching configuration shared by the HTTP-based
/// function types (`HTTP_REQUEST`, `AWS_SERVICE_REQUEST`, and `VAST_REQUEST`).
/// When you provide this configuration, MediaTailor caches the function's
/// responses that have one of the following HTTP status codes: `200`, `203`,
/// `204`, `404`, `405`, `410`, `414`, and `501`. For a cacheable response,
/// MediaTailor caches it for the number of seconds given by the response's
/// `Cache-Control` `max-age` directive, limited to the range between
/// `TtlMinimumSeconds` and `TtlMaximumSeconds`. If the response has no
/// `Cache-Control` `max-age` directive, MediaTailor caches it for
/// `TtlMinimumSeconds` seconds. Cached HTTP responses are scoped per playback
/// configuration, not per function.
pub const HttpRequestCacheConfiguration = struct {
    /// A JSONata expression that MediaTailor evaluates to a custom cache key. By
    /// default, the cache key is a hash of the HTTP URL, the request body, and the
    /// HTTP method; request headers are not included. You can specify a custom
    /// cache key expression to vary caching by request headers and more. The
    /// evaluated key must be smaller than 1 KB; otherwise the HTTP function will
    /// fail.
    key: ?[]const u8 = null,

    /// The upper bound, in seconds, on how long MediaTailor caches a response. This
    /// value must be greater than or equal to `TtlMinimumSeconds`.
    ttl_maximum_seconds: i32,

    /// The lower bound, in seconds, on how long MediaTailor caches a response.
    /// MediaTailor also uses this value as the cache duration when a response has
    /// no `Cache-Control` `max-age` directive.
    ttl_minimum_seconds: i32,

    pub const json_field_names = .{
        .key = "Key",
        .ttl_maximum_seconds = "TtlMaximumSeconds",
        .ttl_minimum_seconds = "TtlMinimumSeconds",
    };
};
