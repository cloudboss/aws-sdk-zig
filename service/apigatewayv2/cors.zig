/// Represents a CORS configuration. Supported only for HTTP APIs. See
/// [Configuring
/// CORS](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-cors.html) for more information.
pub const Cors = struct {
    /// Specifies whether credentials are included in the CORS request. Supported
    /// only for HTTP APIs.
    allow_credentials: ?bool = null,

    /// Represents a collection of allowed headers. Supported only for HTTP APIs.
    allow_headers: ?[]const []const u8 = null,

    /// Represents a collection of allowed HTTP methods. Supported only for HTTP
    /// APIs.
    allow_methods: ?[]const []const u8 = null,

    /// Represents a collection of allowed origins. Supported only for HTTP APIs.
    allow_origins: ?[]const []const u8 = null,

    /// Represents a collection of exposed headers. Supported only for HTTP APIs.
    expose_headers: ?[]const []const u8 = null,

    /// The number of seconds that the browser should cache preflight request
    /// results. Supported only for HTTP APIs.
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
