/// Configuration for URL redirection in a specific direction (host-to-client or
/// client-to-host). When enabled, URLs matching the allowed or denied patterns
/// are redirected accordingly. The denied list takes precedence over the
/// allowed list.
pub const UrlRedirectionConfig = struct {
    /// List of URL patterns that are allowed to be redirected. URLs matching these
    /// patterns will be redirected unless they also match a pattern in the denied
    /// list.
    allowed_urls: ?[]const []const u8 = null,

    /// List of URL patterns that are denied from redirection. This list takes
    /// precedence over the allowed list.
    denied_urls: ?[]const []const u8 = null,

    /// Whether URL redirection is enabled for this direction.
    enabled: bool,

    pub const json_field_names = .{
        .allowed_urls = "AllowedUrls",
        .denied_urls = "DeniedUrls",
        .enabled = "Enabled",
    };
};
