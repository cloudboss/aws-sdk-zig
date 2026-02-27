pub const CancelTimerFailedCause = enum {
    timer_id_unknown,
    operation_not_permitted,

    pub const json_field_names = .{
        .timer_id_unknown = "TIMER_ID_UNKNOWN",
        .operation_not_permitted = "OPERATION_NOT_PERMITTED",
    };
};
