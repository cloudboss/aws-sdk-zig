const GameServerIpProtocolSupported = @import("game_server_ip_protocol_supported.zig").GameServerIpProtocolSupported;

/// Configuration settings for player gateway. Use these settings to specify
/// advanced options for how player gateway handles connections.
pub const PlayerGatewayConfiguration = struct {
    /// The IP protocol that your game servers support for player connections
    /// through player gateway. If the value is set to `IPv4`, GameLift will install
    /// and execute a lightweight IP translation software on fleet instances to
    /// receive and transform incoming IPv6 traffic to IPv4. If the value is set to
    /// `DUAL_STACK`, the lightweight IP translation software will not be installed
    /// on fleet instances. `DUAL_STACK` provides slightly better performance than
    /// `IPv4`.
    game_server_ip_protocol_supported: ?GameServerIpProtocolSupported = null,

    pub const json_field_names = .{
        .game_server_ip_protocol_supported = "GameServerIpProtocolSupported",
    };
};
