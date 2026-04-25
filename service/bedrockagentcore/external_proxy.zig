const ProxyCredentials = @import("proxy_credentials.zig").ProxyCredentials;

/// Configuration for a customer-managed external proxy server. Includes server
/// location, optional domain-based routing patterns, and authentication
/// credentials.
pub const ExternalProxy = struct {
    /// Optional authentication credentials for the proxy server. If omitted, the
    /// proxy is accessed without authentication (useful for IP-allowlisted
    /// proxies).
    credentials: ?ProxyCredentials = null,

    /// Optional array of domain patterns that should route through this specific
    /// proxy. Supports `.example.com` for subdomain matching (matches any subdomain
    /// of example.com) or `example.com` for exact domain matching. If omitted, this
    /// proxy acts as a catch-all for domains not matched by other proxies. Maximum
    /// 100 patterns per proxy, each up to 253 characters.
    domain_patterns: ?[]const []const u8 = null,

    /// The port number of the proxy server. Valid range: 1-65535.
    port: i32,

    /// The hostname of the proxy server. Must be a valid DNS hostname (maximum 253
    /// characters).
    server: []const u8,

    pub const json_field_names = .{
        .credentials = "credentials",
        .domain_patterns = "domainPatterns",
        .port = "port",
        .server = "server",
    };
};
