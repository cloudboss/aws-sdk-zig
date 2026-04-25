/// Represents a new player session that is created as a result of a successful
/// FlexMatch
/// match. A successful match automatically creates new player sessions for
/// every player ID
/// in the original matchmaking request.
///
/// When players connect to the match's game session, they must include both
/// player ID and
/// player session ID in order to claim their assigned player slot.
pub const MatchedPlayerSession = struct {
    /// A unique identifier for a player
    player_id: ?[]const u8 = null,

    /// A unique identifier for a player session. PlayerSessionId will only be
    /// populated for player sessions that are in ACTIVE or RESERVED status when the
    /// ticket is completed.
    player_session_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .player_id = "PlayerId",
        .player_session_id = "PlayerSessionId",
    };
};
