/// Regional latency information for a player, used when requesting a new game
/// session.
/// This value indicates the amount of time lag that exists when the player is
/// connected to
/// a fleet in the specified Region. The relative difference between a player's
/// latency
/// values for multiple Regions are used to determine which fleets are best
/// suited to place
/// a new game session for the player.
pub const PlayerLatency = struct {
    /// Amount of time that represents the time lag experienced by the player when
    /// connected
    /// to the specified Region.
    latency_in_milliseconds: ?f32 = null,

    /// A unique identifier for a player associated with the latency data.
    player_id: ?[]const u8 = null,

    /// Name of the Region that is associated with the latency value.
    region_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .latency_in_milliseconds = "LatencyInMilliseconds",
        .player_id = "PlayerId",
        .region_identifier = "RegionIdentifier",
    };
};
