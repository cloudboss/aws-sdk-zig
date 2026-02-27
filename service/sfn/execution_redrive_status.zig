pub const ExecutionRedriveStatus = enum {
    redrivable,
    not_redrivable,
    redrivable_by_map_run,

    pub const json_field_names = .{
        .redrivable = "REDRIVABLE",
        .not_redrivable = "NOT_REDRIVABLE",
        .redrivable_by_map_run = "REDRIVABLE_BY_MAP_RUN",
    };
};
