pub const Monotonicity = enum {
    decreasing,
    increasing,
    static,

    pub const json_field_names = .{
        .decreasing = "DECREASING",
        .increasing = "INCREASING",
        .static = "STATIC",
    };
};
