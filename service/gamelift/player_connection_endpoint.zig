/// Network address(es) and port(s) for connecting to a game session.
pub const PlayerConnectionEndpoint = struct {
    /// IP address for connecting to the game session. When player gateway is
    /// enabled, this is a player gateway IP address. When player gateway is
    /// disabled, this is the game server IP address.
    ip_address: ?[]const u8 = null,

    /// Port number for connecting to the game session. When player gateway is
    /// enabled, this is a player gateway port. When player gateway is disabled,
    /// this is the game server port.
    port: ?i32 = null,

    pub const json_field_names = .{
        .ip_address = "IpAddress",
        .port = "Port",
    };
};
