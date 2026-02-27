pub const StatisticsAutoGenerationMode = enum {
    disable_autocompute,
    enable_autocompute,
    refresh,

    pub const json_field_names = .{
        .disable_autocompute = "DISABLE_AUTOCOMPUTE",
        .enable_autocompute = "ENABLE_AUTOCOMPUTE",
        .refresh = "REFRESH",
    };
};
