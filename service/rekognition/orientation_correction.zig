pub const OrientationCorrection = enum {
    rotate_0,
    rotate_90,
    rotate_180,
    rotate_270,

    pub const json_field_names = .{
        .rotate_0 = "ROTATE_0",
        .rotate_90 = "ROTATE_90",
        .rotate_180 = "ROTATE_180",
        .rotate_270 = "ROTATE_270",
    };
};
