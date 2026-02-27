pub const RadarChartShape = enum {
    circle,
    polygon,

    pub const json_field_names = .{
        .circle = "CIRCLE",
        .polygon = "POLYGON",
    };
};
