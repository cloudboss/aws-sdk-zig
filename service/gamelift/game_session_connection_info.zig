const MatchedPlayerSession = @import("matched_player_session.zig").MatchedPlayerSession;
const PlayerGatewayStatus = @import("player_gateway_status.zig").PlayerGatewayStatus;

/// Connection information for a new game session that is created in response to
/// a start
/// matchmaking request. Once a match is made, the FlexMatch engine creates a
/// new game session
/// for it. This information, including the game session endpoint and player
/// sessions for
/// each player in the original matchmaking request, is added to the matchmaking
/// ticket.
pub const GameSessionConnectionInfo = struct {
    /// The DNS identifier assigned to the instance that is running the game
    /// session. Values have
    /// the following format:
    ///
    /// * TLS-enabled fleets: `..amazongamelift.com`.
    ///
    /// * Non-TLS-enabled fleets: `ec2-.compute.amazonaws.com`. (See
    /// [Amazon EC2 Instance IP
    /// Addressing](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-instance-addressing.html#concepts-public-addresses).)
    ///
    /// When connecting to a game session that is running on a TLS-enabled fleet,
    /// you must use the DNS name, not the IP address.
    dns_name: ?[]const u8 = null,

    /// A unique identifier for the game session. Use the game session ID.
    game_session_arn: ?[]const u8 = null,

    /// The IP address of the game session. To connect to a Amazon GameLift Servers
    /// game server, an app needs both the IP address and port number.
    ip_address: ?[]const u8 = null,

    /// A collection of player session IDs, one for each player ID that was included
    /// in the
    /// original matchmaking request.
    matched_player_sessions: ?[]const MatchedPlayerSession = null,

    /// The current status of player gateway for the game session. Note, even if a
    /// fleet has PlayerGatewayMode configured as `ENABLED`, player gateway might
    /// not be available in a specific location. For more information about
    /// locations where player gateway is supported, see [supported
    /// locations](https://docs.aws.amazon.com/gameliftservers/latest/developerguide/gamelift-regions.html).
    ///
    /// Possible values include:
    ///
    /// * `ENABLED` -- Player gateway is available for this game session.
    ///
    /// * `DISABLED` -- Player gateway is not available for this game session.
    player_gateway_status: ?PlayerGatewayStatus = null,

    /// The port number for the game session. To connect to a Amazon GameLift
    /// Servers game server, an app needs both the IP address and port number.
    port: ?i32 = null,

    pub const json_field_names = .{
        .dns_name = "DnsName",
        .game_session_arn = "GameSessionArn",
        .ip_address = "IpAddress",
        .matched_player_sessions = "MatchedPlayerSessions",
        .player_gateway_status = "PlayerGatewayStatus",
        .port = "Port",
    };
};
