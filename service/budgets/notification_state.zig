pub const NotificationState = enum {
    ok,
    alarm,

    pub const json_field_names = .{
        .ok = "OK",
        .alarm = "ALARM",
    };
};
