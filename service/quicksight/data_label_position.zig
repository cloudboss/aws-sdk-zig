pub const DataLabelPosition = enum {
    inside,
    outside,
    left,
    top,
    bottom,
    right,

    pub const json_field_names = .{
        .inside = "INSIDE",
        .outside = "OUTSIDE",
        .left = "LEFT",
        .top = "TOP",
        .bottom = "BOTTOM",
        .right = "RIGHT",
    };
};
