pub const JobType = enum {
    launch,
    terminate,

    pub const json_field_names = .{
        .launch = "LAUNCH",
        .terminate = "TERMINATE",
    };
};
