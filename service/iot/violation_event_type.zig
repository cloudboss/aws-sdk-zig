pub const ViolationEventType = enum {
    in_alarm,
    alarm_cleared,
    alarm_invalidated,

    pub const json_field_names = .{
        .in_alarm = "IN_ALARM",
        .alarm_cleared = "ALARM_CLEARED",
        .alarm_invalidated = "ALARM_INVALIDATED",
    };
};
