/// The credentials for authenticating with a web proxy server.
pub const WebProxyCredentials = struct {
    /// The password for authenticating with the web proxy server.
    web_proxy_password: []const u8,

    /// The username for authenticating with the web proxy server.
    web_proxy_username: []const u8,

    pub const json_field_names = .{
        .web_proxy_password = "WebProxyPassword",
        .web_proxy_username = "WebProxyUsername",
    };
};
