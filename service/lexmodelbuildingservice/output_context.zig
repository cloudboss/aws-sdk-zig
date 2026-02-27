/// The specification of an output context that is set when an intent is
/// fulfilled.
pub const OutputContext = struct {
    /// The name of the context.
    name: []const u8,

    /// The number of seconds that the context should be active after it is
    /// first sent in a `PostContent` or `PostText`
    /// response. You can set the value between 5 and 86,400 seconds (24
    /// hours).
    time_to_live_in_seconds: i32,

    /// The number of conversation turns that the context should be active. A
    /// conversation turn is one `PostContent` or `PostText`
    /// request and the corresponding response from Amazon Lex.
    turns_to_live: i32,

    pub const json_field_names = .{
        .name = "name",
        .time_to_live_in_seconds = "timeToLiveInSeconds",
        .turns_to_live = "turnsToLive",
    };
};
