pub const PipPosition = enum {
    top_left,
    top_right,
    bottom_left,
    bottom_right,

    pub const json_field_names = .{
        .top_left = "TOP_LEFT",
        .top_right = "TOP_RIGHT",
        .bottom_left = "BOTTOM_LEFT",
        .bottom_right = "BOTTOM_RIGHT",
    };
};
