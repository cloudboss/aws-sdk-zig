/// The possible states of a channel alert. SET - The alert is actively
/// happening. CLEARED - The alert is no longer happening.
pub const ChannelAlertState = enum {
    set,
    cleared,

    pub const json_field_names = .{
        .set = "SET",
        .cleared = "CLEARED",
    };
};
