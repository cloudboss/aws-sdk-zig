const UrlRedirectionConfig = @import("url_redirection_config.zig").UrlRedirectionConfig;

/// Configuration for bidirectional URL redirection between the streaming
/// session and the local client. Use HostToClient to redirect URLs from the
/// remote desktop to the local browser.
pub const ContentRedirection = struct {
    /// Configuration for redirecting URLs from the remote desktop to the local
    /// client browser.
    host_to_client: ?UrlRedirectionConfig = null,

    pub const json_field_names = .{
        .host_to_client = "HostToClient",
    };
};
