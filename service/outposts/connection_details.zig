/// Information about a connection.
pub const ConnectionDetails = struct {
    /// The allowed IP addresses.
    allowed_ips: ?[]const []const u8,

    /// The public key of the client.
    client_public_key: ?[]const u8,

    /// The client tunnel address.
    client_tunnel_address: ?[]const u8,

    /// The endpoint for the server.
    server_endpoint: ?[]const u8,

    /// The public key of the server.
    server_public_key: ?[]const u8,

    /// The server tunnel address.
    server_tunnel_address: ?[]const u8,

    pub const json_field_names = .{
        .allowed_ips = "AllowedIps",
        .client_public_key = "ClientPublicKey",
        .client_tunnel_address = "ClientTunnelAddress",
        .server_endpoint = "ServerEndpoint",
        .server_public_key = "ServerPublicKey",
        .server_tunnel_address = "ServerTunnelAddress",
    };
};
