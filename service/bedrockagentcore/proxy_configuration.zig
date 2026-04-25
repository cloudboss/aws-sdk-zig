const ProxyBypass = @import("proxy_bypass.zig").ProxyBypass;
const Proxy = @import("proxy.zig").Proxy;

/// Configuration for routing browser traffic through customer-managed proxy
/// servers. Supports 1-5 proxy servers for domain-based routing and proxy
/// bypass rules.
pub const ProxyConfiguration = struct {
    /// Optional configuration for domains that should bypass all proxies and
    /// connect directly to their destination, like the internet. Takes precedence
    /// over all proxy routing rules.
    bypass: ?ProxyBypass = null,

    /// An array of 1-5 proxy server configurations for domain-based routing. Each
    /// proxy can specify which domains it handles via `domainPatterns`, enabling
    /// flexible routing of different traffic through different proxies based on
    /// destination domain.
    proxies: []const Proxy,

    pub const json_field_names = .{
        .bypass = "bypass",
        .proxies = "proxies",
    };
};
