/// Information about a player session. This object contains only the player ID
/// and player
/// session ID. To retrieve full details on a player session, call
/// [DescribePlayerSessions](https://docs.aws.amazon.com/gamelift/latest/apireference/API_DescribePlayerSessions.html) with the player session ID.
pub const PlacedPlayerSession = struct {
    /// A unique identifier for a player that is associated with this player
    /// session.
    player_id: ?[]const u8,

    /// A unique identifier for a player session.
    player_session_id: ?[]const u8,

    pub const json_field_names = .{
        .player_id = "PlayerId",
        .player_session_id = "PlayerSessionId",
    };
};
