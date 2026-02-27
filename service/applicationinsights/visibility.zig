pub const Visibility = enum {
    ignored,
    visible,

    pub const json_field_names = .{
        .ignored = "IGNORED",
        .visible = "VISIBLE",
    };
};
