pub const LineChartLineStyle = enum {
    solid,
    dotted,
    dashed,

    pub const json_field_names = .{
        .solid = "SOLID",
        .dotted = "DOTTED",
        .dashed = "DASHED",
    };
};
