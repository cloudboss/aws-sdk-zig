/// Av1 Bit Depth
pub const Av1BitDepth = enum {
    depth_10,
    depth_8,

    pub const json_field_names = .{
        .depth_10 = "DEPTH_10",
        .depth_8 = "DEPTH_8",
    };
};
