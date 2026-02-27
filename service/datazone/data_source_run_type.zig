pub const DataSourceRunType = enum {
    prioritized,
    scheduled,

    pub const json_field_names = .{
        .prioritized = "PRIORITIZED",
        .scheduled = "SCHEDULED",
    };
};
