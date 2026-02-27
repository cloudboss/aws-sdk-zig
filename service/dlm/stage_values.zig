pub const StageValues = enum {
    pre,
    post,

    pub const json_field_names = .{
        .pre = "PRE",
        .post = "POST",
    };
};
