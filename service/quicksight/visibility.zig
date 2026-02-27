pub const Visibility = enum {
    hidden,
    visible,

    pub const json_field_names = .{
        .hidden = "HIDDEN",
        .visible = "VISIBLE",
    };
};
