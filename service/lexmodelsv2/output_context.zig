/// Describes a session context that is activated when an intent is
/// fulfilled.
pub const OutputContext = struct {
    /// The name of the output context.
    name: []const u8,

    /// The amount of time, in seconds, that the output context should
    /// remain active. The time is figured from the first time the context is
    /// sent to the user.
    time_to_live_in_seconds: i32,

    /// The number of conversation turns that the output context should
    /// remain active. The number of turns is counted from the first time that
    /// the context is sent to the user.
    turns_to_live: i32,

    pub const json_field_names = .{
        .name = "name",
        .time_to_live_in_seconds = "timeToLiveInSeconds",
        .turns_to_live = "turnsToLive",
    };
};
