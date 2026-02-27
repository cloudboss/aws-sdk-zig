pub const AlarmStateName = enum {
    disabled,
    normal,
    active,
    acknowledged,
    snooze_disabled,
    latched,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .normal = "NORMAL",
        .active = "ACTIVE",
        .acknowledged = "ACKNOWLEDGED",
        .snooze_disabled = "SNOOZE_DISABLED",
        .latched = "LATCHED",
    };
};
