/// Configuration for domains that should bypass all proxies and connect
/// directly to the internet. These bypass rules take precedence over all proxy
/// routing rules.
pub const ProxyBypass = struct {
    /// Array of domain patterns that should bypass the proxy. Supports
    /// `.amazonaws.com` for subdomain matching or `amazonaws.com` for exact domain
    /// matching. Requests to these domains connect directly without using any
    /// proxy. Maximum 253 characters per pattern.
    domain_patterns: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .domain_patterns = "domainPatterns",
    };
};
