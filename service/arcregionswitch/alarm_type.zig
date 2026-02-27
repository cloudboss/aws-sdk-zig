pub const AlarmType = enum {
    application_health,
    trigger,

    pub const json_field_names = .{
        .application_health = "APPLICATION_HEALTH",
        .trigger = "TRIGGER",
    };
};
