pub const AlarmState = enum {
    ok,
    alarm,
    insufficient_data,

    pub const json_field_names = .{
        .ok = "OK",
        .alarm = "ALARM",
        .insufficient_data = "INSUFFICIENT_DATA",
    };
};
