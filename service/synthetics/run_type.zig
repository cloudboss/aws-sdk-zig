pub const RunType = enum {
    canary_run,
    dry_run,

    pub const json_field_names = .{
        .canary_run = "CANARY_RUN",
        .dry_run = "DRY_RUN",
    };
};
