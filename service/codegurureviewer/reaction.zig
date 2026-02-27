pub const Reaction = enum {
    thumbs_up,
    thumbs_down,

    pub const json_field_names = .{
        .thumbs_up = "THUMBS_UP",
        .thumbs_down = "THUMBS_DOWN",
    };
};
