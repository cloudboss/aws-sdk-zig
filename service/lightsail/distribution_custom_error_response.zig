/// Describes a custom error response for a Lightsail distribution. A custom
/// error response
/// specifies the page that the distribution returns to the viewer. It also
/// specifies the HTTP
/// status code that the distribution sends when the origin responds with a
/// given HTTP error code.
pub const DistributionCustomErrorResponse = struct {
    /// The minimum time, in seconds, that the distribution caches the custom error
    /// response
    /// before requesting the object again from the origin. If you don't specify a
    /// value, the default
    /// is `10` seconds.
    error_caching_min_ttl: ?i64 = null,

    /// The HTTP error code from the origin that triggers the custom error response
    /// (for example,
    /// `403` or `404`).
    error_code: ?i32 = null,

    /// The HTTP status code that the distribution returns to the viewer for the
    /// custom error
    /// response.
    response_code: ?[]const u8 = null,

    /// The path to the custom error page that the distribution returns to the
    /// viewer (for
    /// example, `/404.html`). The path must begin with a forward slash (`/`)
    /// and reference an object that is available from the origin.
    response_page_path: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_caching_min_ttl = "errorCachingMinTTL",
        .error_code = "errorCode",
        .response_code = "responseCode",
        .response_page_path = "responsePagePath",
    };
};
