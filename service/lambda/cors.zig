/// The [cross-origin resource sharing
/// (CORS)](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS) settings for
/// your Lambda function URL. Use CORS to grant access to your function URL from
/// any origin. You can also use CORS to control access for specific HTTP
/// headers and methods in requests to your function URL.
pub const Cors = struct {
    /// Whether to allow cookies or other credentials in requests to your function
    /// URL. The default is `false`.
    allow_credentials: ?bool = null,

    /// The HTTP headers that origins can include in requests to your function URL.
    /// For example: `Date`, `Keep-Alive`, `X-Custom-Header`.
    allow_headers: ?[]const []const u8 = null,

    /// The HTTP methods that are allowed when calling your function URL. For
    /// example: `GET`, `POST`, `DELETE`, or the wildcard character (`*`).
    allow_methods: ?[]const []const u8 = null,

    /// The origins that can access your function URL. You can list any number of
    /// specific origins, separated by a comma. For example:
    /// `https://www.example.com`, `http://localhost:60905`.
    ///
    /// Alternatively, you can grant access to all origins using the wildcard
    /// character (`*`).
    allow_origins: ?[]const []const u8 = null,

    /// The HTTP headers in your function response that you want to expose to
    /// origins that call your function URL. For example: `Date`, `Keep-Alive`,
    /// `X-Custom-Header`.
    expose_headers: ?[]const []const u8 = null,

    /// The maximum amount of time, in seconds, that web browsers can cache results
    /// of a preflight request. By default, this is set to `0`, which means that the
    /// browser doesn't cache results.
    max_age: ?i32 = null,

    pub const json_field_names = .{
        .allow_credentials = "AllowCredentials",
        .allow_headers = "AllowHeaders",
        .allow_methods = "AllowMethods",
        .allow_origins = "AllowOrigins",
        .expose_headers = "ExposeHeaders",
        .max_age = "MaxAge",
    };
};
