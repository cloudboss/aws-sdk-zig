const MethodName = @import("method_name.zig").MethodName;

/// A rule for a CORS policy. You can add up to 100 rules to a CORS policy. If
/// more than
/// one rule applies, the service uses the first applicable rule listed.
pub const CorsRule = struct {
    /// Specifies which headers are allowed in a preflight `OPTIONS` request
    /// through the `Access-Control-Request-Headers` header. Each header name that
    /// is
    /// specified in `Access-Control-Request-Headers` must have a corresponding
    /// entry in
    /// the rule. Only the headers that were requested are sent back.
    ///
    /// This element can contain only one wildcard character (*).
    allowed_headers: []const []const u8,

    /// Identifies an HTTP method that the origin that is specified in the rule is
    /// allowed to
    /// execute.
    ///
    /// Each CORS rule must contain at least one `AllowedMethods` and one
    /// `AllowedOrigins` element.
    allowed_methods: ?[]const MethodName,

    /// One or more response headers that you want users to be able to access from
    /// their
    /// applications (for example, from a JavaScript `XMLHttpRequest` object).
    ///
    /// Each CORS rule must have at least one `AllowedOrigins` element. The string
    /// value can include only one wildcard character (*), for example,
    /// http://*.example.com.
    /// Additionally, you can specify only one wildcard character to allow
    /// cross-origin access for
    /// all origins.
    allowed_origins: []const []const u8,

    /// One or more headers in the response that you want users to be able to access
    /// from
    /// their applications (for example, from a JavaScript `XMLHttpRequest`
    /// object).
    ///
    /// This element is optional for each rule.
    expose_headers: ?[]const []const u8,

    /// The time in seconds that your browser caches the preflight response for the
    /// specified
    /// resource.
    ///
    /// A CORS rule can have only one `MaxAgeSeconds` element.
    max_age_seconds: i32 = 0,

    pub const json_field_names = .{
        .allowed_headers = "AllowedHeaders",
        .allowed_methods = "AllowedMethods",
        .allowed_origins = "AllowedOrigins",
        .expose_headers = "ExposeHeaders",
        .max_age_seconds = "MaxAgeSeconds",
    };
};
