pub const VerticalTextAlignment = enum {
    top,
    middle,
    bottom,
    auto,

    pub const json_field_names = .{
        .top = "TOP",
        .middle = "MIDDLE",
        .bottom = "BOTTOM",
        .auto = "AUTO",
    };
};
