pub const FlowSize = enum {
    medium,
    large,
    large_4_x,

    pub const json_field_names = .{
        .medium = "MEDIUM",
        .large = "LARGE",
        .large_4_x = "LARGE_4X",
    };
};
