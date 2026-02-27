pub const LegendPosition = enum {
    auto,
    right,
    bottom,
    top,

    pub const json_field_names = .{
        .auto = "AUTO",
        .right = "RIGHT",
        .bottom = "BOTTOM",
        .top = "TOP",
    };
};
