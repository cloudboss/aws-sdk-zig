pub const FailbackLaunchType = enum {
    recovery,
    drill,

    pub const json_field_names = .{
        .recovery = "RECOVERY",
        .drill = "DRILL",
    };
};
