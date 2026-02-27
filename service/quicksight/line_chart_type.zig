pub const LineChartType = enum {
    line,
    area,
    stacked_area,

    pub const json_field_names = .{
        .line = "LINE",
        .area = "AREA",
        .stacked_area = "STACKED_AREA",
    };
};
