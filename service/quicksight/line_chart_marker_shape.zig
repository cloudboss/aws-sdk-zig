pub const LineChartMarkerShape = enum {
    circle,
    triangle,
    square,
    diamond,
    rounded_square,

    pub const json_field_names = .{
        .circle = "CIRCLE",
        .triangle = "TRIANGLE",
        .square = "SQUARE",
        .diamond = "DIAMOND",
        .rounded_square = "ROUNDED_SQUARE",
    };
};
