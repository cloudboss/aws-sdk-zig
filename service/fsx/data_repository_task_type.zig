pub const DataRepositoryTaskType = enum {
    @"export",
    import,
    eviction,
    auto_triggered_eviction,

    pub const json_field_names = .{
        .@"export" = "EXPORT",
        .import = "IMPORT",
        .eviction = "EVICTION",
        .auto_triggered_eviction = "AUTO_TRIGGERED_EVICTION",
    };
};
