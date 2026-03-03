/// Contains the cross-origin resource sharing (CORS) configuration for the API.
/// CORS is
/// only supported for HTTP APIs.
pub const AwsCorsConfiguration = struct {
    /// Indicates whether the CORS request includes credentials.
    allow_credentials: ?bool = null,

    /// The allowed headers for CORS requests.
    allow_headers: ?[]const []const u8 = null,

    /// The allowed methods for CORS requests.
    allow_methods: ?[]const []const u8 = null,

    /// The allowed origins for CORS requests.
    allow_origins: ?[]const []const u8 = null,

    /// The exposed headers for CORS requests.
    expose_headers: ?[]const []const u8 = null,

    /// The number of seconds for which the browser caches preflight request
    /// results.
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
