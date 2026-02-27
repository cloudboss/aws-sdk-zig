pub const ActionsSuppressedBy = enum {
    wait_period,
    extension_period,
    alarm,

    pub const json_field_names = .{
        .wait_period = "WaitPeriod",
        .extension_period = "ExtensionPeriod",
        .alarm = "Alarm",
    };
};
