pub const ExecutionRedriveFilter = enum {
    redriven,
    not_redriven,

    pub const json_field_names = .{
        .redriven = "REDRIVEN",
        .not_redriven = "NOT_REDRIVEN",
    };
};
