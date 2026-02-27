pub const ResizeOption = enum {
    fixed,
    responsive,

    pub const json_field_names = .{
        .fixed = "FIXED",
        .responsive = "RESPONSIVE",
    };
};
