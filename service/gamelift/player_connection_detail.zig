const PlayerConnectionEndpoint = @import("player_connection_endpoint.zig").PlayerConnectionEndpoint;

/// Connection information for a game client to connect to a game session. This
/// object contains the IP address(es), port(s), and authentication details your
/// game client needs to establish a connection.
///
/// **With player gateway enabled:** Contains relay endpoints and a player
/// gateway token. Your game client must prepend player gateway token to each
/// payload for validation and connection through relay endpoints.
///
/// **With player gateway disabled:** Contains game server endpoint. Player
/// gateway token and expiration fields are empty.
pub const PlayerConnectionDetail = struct {
    /// List of connection endpoints for the game client. Your game client uses
    /// these IP address(es) and port(s) to connect to the game session.
    ///
    /// When player gateway is enabled, these are relay endpoints with benefits such
    /// as DDoS protection. When disabled, this is the game server endpoint.
    endpoints: ?[]const PlayerConnectionEndpoint = null,

    /// When player gateway is enabled, this is the timestamp indicating when player
    /// gateway token expires. Your game backend should call
    /// [GetPlayerConnectionDetails](https://docs.aws.amazon.com/gamelift/latest/apireference/API_GetPlayerConnectionDetails.html) to retrieve fresh connection information for your game clients before this time. Format is a number expressed in Unix time as milliseconds (for example `"1469498468.057"`).
    ///
    /// This value is empty when player gateway is disabled.
    expiration: ?i64 = null,

    /// Access token that your game client must prepend to all traffic sent through
    /// player gateway. Player gateway verifies identity and authorizes connection
    /// based on this token.
    ///
    /// This value is empty when player gateway is disabled.
    player_gateway_token: ?[]const u8 = null,

    /// A unique identifier for a player associated with this connection.
    player_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .endpoints = "Endpoints",
        .expiration = "Expiration",
        .player_gateway_token = "PlayerGatewayToken",
        .player_id = "PlayerId",
    };
};
