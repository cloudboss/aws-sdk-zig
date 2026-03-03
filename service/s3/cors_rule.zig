/// Specifies a cross-origin access rule for an Amazon S3 bucket.
pub const CORSRule = struct {
    /// Headers that are specified in the `Access-Control-Request-Headers` header.
    /// These headers
    /// are allowed in a preflight OPTIONS request. In response to any preflight
    /// OPTIONS request, Amazon S3 returns
    /// any requested headers that are allowed.
    allowed_headers: ?[]const []const u8 = null,

    /// An HTTP method that you allow the origin to execute. Valid values are `GET`,
    /// `PUT`, `HEAD`, `POST`, and `DELETE`.
    allowed_methods: []const []const u8,

    /// One or more origins you want customers to be able to access the bucket from.
    allowed_origins: []const []const u8,

    /// One or more headers in the response that you want customers to be able to
    /// access from their
    /// applications (for example, from a JavaScript `XMLHttpRequest` object).
    expose_headers: ?[]const []const u8 = null,

    /// Unique identifier for the rule. The value cannot be longer than 255
    /// characters.
    id: ?[]const u8 = null,

    /// The time in seconds that your browser is to cache the preflight response for
    /// the specified
    /// resource.
    max_age_seconds: ?i32 = null,
};
