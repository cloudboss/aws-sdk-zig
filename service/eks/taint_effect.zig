pub const TaintEffect = enum {
    no_schedule,
    no_execute,
    prefer_no_schedule,

    pub const json_field_names = .{
        .no_schedule = "NO_SCHEDULE",
        .no_execute = "NO_EXECUTE",
        .prefer_no_schedule = "PREFER_NO_SCHEDULE",
    };
};
