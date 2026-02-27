pub const BarsArrangement = enum {
    clustered,
    stacked,
    stacked_percent,

    pub const json_field_names = .{
        .clustered = "CLUSTERED",
        .stacked = "STACKED",
        .stacked_percent = "STACKED_PERCENT",
    };
};
