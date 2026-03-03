/// Player information for use when creating player sessions using a game
/// session
/// placement request.
pub const DesiredPlayerSession = struct {
    /// Developer-defined information related to a player. Amazon GameLift Servers
    /// does not use this data, so it can be formatted as needed for use in the
    /// game.
    player_data: ?[]const u8 = null,

    /// A unique identifier for a player to associate with the player session.
    player_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .player_data = "PlayerData",
        .player_id = "PlayerId",
    };
};
