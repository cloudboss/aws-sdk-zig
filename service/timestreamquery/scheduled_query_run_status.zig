pub const ScheduledQueryRunStatus = enum {
    auto_trigger_success,
    auto_trigger_failure,
    manual_trigger_success,
    manual_trigger_failure,

    pub const json_field_names = .{
        .auto_trigger_success = "AUTO_TRIGGER_SUCCESS",
        .auto_trigger_failure = "AUTO_TRIGGER_FAILURE",
        .manual_trigger_success = "MANUAL_TRIGGER_SUCCESS",
        .manual_trigger_failure = "MANUAL_TRIGGER_FAILURE",
    };
};
