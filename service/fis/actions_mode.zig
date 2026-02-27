pub const ActionsMode = enum {
    skip_all,
    run_all,

    pub const json_field_names = .{
        .skip_all = "SKIP_ALL",
        .run_all = "RUN_ALL",
    };
};
