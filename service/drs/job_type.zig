pub const JobType = enum {
    launch,
    terminate,
    create_converted_snapshot,

    pub const json_field_names = .{
        .launch = "LAUNCH",
        .terminate = "TERMINATE",
        .create_converted_snapshot = "CREATE_CONVERTED_SNAPSHOT",
    };
};
