pub const BarChartOrientation = enum {
    horizontal,
    vertical,

    pub const json_field_names = .{
        .horizontal = "HORIZONTAL",
        .vertical = "VERTICAL",
    };
};
