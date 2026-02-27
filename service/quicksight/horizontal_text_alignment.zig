pub const HorizontalTextAlignment = enum {
    left,
    center,
    right,
    auto,

    pub const json_field_names = .{
        .left = "LEFT",
        .center = "CENTER",
        .right = "RIGHT",
        .auto = "AUTO",
    };
};
