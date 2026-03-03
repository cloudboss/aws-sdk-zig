const RadiusAuthenticationProtocol = @import("radius_authentication_protocol.zig").RadiusAuthenticationProtocol;

/// Contains information about a Remote Authentication Dial In User Service
/// (RADIUS)
/// server.
pub const RadiusSettings = struct {
    /// The protocol specified for your RADIUS endpoints.
    authentication_protocol: ?RadiusAuthenticationProtocol = null,

    /// Not currently used.
    display_label: ?[]const u8 = null,

    /// The port that your RADIUS server is using for communications. Your
    /// self-managed network
    /// must allow inbound traffic over this port from the Directory Service
    /// servers.
    radius_port: ?i32 = null,

    /// The maximum number of times that communication with the RADIUS server is
    /// retried after
    /// the initial attempt.
    radius_retries: i32 = 0,

    /// The fully qualified domain name (FQDN) or IP addresses of the RADIUS server
    /// endpoints,
    /// or the FQDN or IP addresses of your RADIUS server load balancer.
    radius_servers: ?[]const []const u8 = null,

    /// The IPv6 addresses of the RADIUS server endpoints or RADIUS server
    /// load balancer.
    radius_servers_ipv_6: ?[]const []const u8 = null,

    /// The amount of time, in seconds, to wait for the RADIUS server to respond.
    radius_timeout: ?i32 = null,

    /// Required for enabling RADIUS on the directory.
    shared_secret: ?[]const u8 = null,

    /// Not currently used.
    use_same_username: bool = false,

    pub const json_field_names = .{
        .authentication_protocol = "AuthenticationProtocol",
        .display_label = "DisplayLabel",
        .radius_port = "RadiusPort",
        .radius_retries = "RadiusRetries",
        .radius_servers = "RadiusServers",
        .radius_servers_ipv_6 = "RadiusServersIpv6",
        .radius_timeout = "RadiusTimeout",
        .shared_secret = "SharedSecret",
        .use_same_username = "UseSameUsername",
    };
};
