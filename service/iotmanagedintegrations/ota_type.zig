pub const OtaType = enum {
    one_time,
    continuous,

    pub const json_field_names = .{
        .one_time = "ONE_TIME",
        .continuous = "CONTINUOUS",
    };
};
