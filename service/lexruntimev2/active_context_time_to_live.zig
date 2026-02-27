/// The time that a context is active. You can specify the time to live
/// in seconds or in conversation turns.
pub const ActiveContextTimeToLive = struct {
    /// The number of seconds that the context is active. You can specify
    /// between 5 and 86400 seconds (24 hours).
    time_to_live_in_seconds: i32,

    /// The number of turns that the context is active. You can specify up
    /// to 20 turns. Each request and response from the bot is a turn.
    turns_to_live: i32,

    pub const json_field_names = .{
        .time_to_live_in_seconds = "timeToLiveInSeconds",
        .turns_to_live = "turnsToLive",
    };
};
