pub const PresenterPosition = enum {
    top_left,
    top_right,
    bottom_left,
    bottom_right,

    pub const json_field_names = .{
        .top_left = "TopLeft",
        .top_right = "TopRight",
        .bottom_left = "BottomLeft",
        .bottom_right = "BottomRight",
    };
};
