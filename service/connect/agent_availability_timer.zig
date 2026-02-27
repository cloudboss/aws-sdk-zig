pub const AgentAvailabilityTimer = enum {
    time_since_last_activity,
    time_since_last_inbound,

    pub const json_field_names = .{
        .time_since_last_activity = "TIME_SINCE_LAST_ACTIVITY",
        .time_since_last_inbound = "TIME_SINCE_LAST_INBOUND",
    };
};
