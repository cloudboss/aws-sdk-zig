const aws = @import("aws");

const AttributeValue = @import("attribute_value.zig").AttributeValue;

/// Represents a player in matchmaking. When starting a matchmaking request, a
/// player has
/// a player ID, attributes, and may have latency data. Team information is
/// added after a
/// match has been successfully completed.
pub const Player = struct {
    /// A set of values, expressed in milliseconds, that indicates the amount of
    /// latency that a player experiences when connected to Amazon Web Services
    /// Regions. If this property is present, FlexMatch considers placing the match
    /// only in
    /// Regions for which latency is reported.
    ///
    /// If a matchmaker has a rule that evaluates player latency, players must
    /// report latency
    /// in order to be matched. If no latency is reported in this scenario,
    /// FlexMatch assumes that
    /// no Regions are available to the player and the ticket is not matchable.
    latency_in_ms: ?[]const aws.map.MapEntry(i32),

    /// A collection of key:value pairs containing player information for use in
    /// matchmaking.
    /// Player attribute keys must match the *playerAttributes* used in a
    /// matchmaking rule set. Example: `"PlayerAttributes": {"skill": {"N": "23"},
    /// "gameMode": {"S": "deathmatch"}}`.
    ///
    /// You can provide up to 10 `PlayerAttributes`.
    player_attributes: ?[]const aws.map.MapEntry(AttributeValue),

    /// A unique identifier for a player
    player_id: ?[]const u8,

    /// Name of the team that the player is assigned to in a match. Team names are
    /// defined in
    /// a matchmaking rule set.
    team: ?[]const u8,

    pub const json_field_names = .{
        .latency_in_ms = "LatencyInMs",
        .player_attributes = "PlayerAttributes",
        .player_id = "PlayerId",
        .team = "Team",
    };
};
