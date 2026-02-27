const AuthorizationConfig = @import("authorization_config.zig").AuthorizationConfig;

/// Describes an HTTP data source configuration.
pub const HttpDataSourceConfig = struct {
    /// The authorization configuration in case the HTTP endpoint requires
    /// authorization.
    authorization_config: ?AuthorizationConfig,

    /// The HTTP URL endpoint. You can specify either the domain name or IP, and
    /// port
    /// combination, and the URL scheme must be HTTP or HTTPS. If you don't specify
    /// the port,
    /// AppSync uses the default port 80 for the HTTP endpoint and port 443 for
    /// HTTPS endpoints.
    endpoint: ?[]const u8,

    pub const json_field_names = .{
        .authorization_config = "authorizationConfig",
        .endpoint = "endpoint",
    };
};
