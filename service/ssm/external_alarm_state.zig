pub const ExternalAlarmState = enum {
    unknown,
    alarm,

    pub const json_field_names = .{
        .unknown = "UNKNOWN",
        .alarm = "ALARM",
    };
};
