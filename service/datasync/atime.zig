pub const Atime = enum {
    none,
    best_effort,

    pub const json_field_names = .{
        .none = "NONE",
        .best_effort = "BEST_EFFORT",
    };
};
