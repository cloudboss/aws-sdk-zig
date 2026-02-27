pub const AmiSortBy = enum {
    critical,
    high,
    all,
    affected_instances,

    pub const json_field_names = .{
        .critical = "CRITICAL",
        .high = "HIGH",
        .all = "ALL",
        .affected_instances = "AFFECTED_INSTANCES",
    };
};
