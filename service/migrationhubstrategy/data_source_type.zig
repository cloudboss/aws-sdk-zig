pub const DataSourceType = enum {
    ads,
    mpa,
    import,
    mhsr_collector,

    pub const json_field_names = .{
        .ads = "ADS",
        .mpa = "MPA",
        .import = "IMPORT",
        .mhsr_collector = "MHSR_COLLECTOR",
    };
};
