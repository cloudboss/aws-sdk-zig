pub const StartTimerFailedCause = enum {
    timer_id_already_in_use,
    open_timers_limit_exceeded,
    timer_creation_rate_exceeded,
    operation_not_permitted,

    pub const json_field_names = .{
        .timer_id_already_in_use = "TIMER_ID_ALREADY_IN_USE",
        .open_timers_limit_exceeded = "OPEN_TIMERS_LIMIT_EXCEEDED",
        .timer_creation_rate_exceeded = "TIMER_CREATION_RATE_EXCEEDED",
        .operation_not_permitted = "OPERATION_NOT_PERMITTED",
    };
};
