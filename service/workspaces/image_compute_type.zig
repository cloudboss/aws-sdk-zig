pub const ImageComputeType = enum {
    base,
    graphics_g4_dn,
    graphics_g6,

    pub const json_field_names = .{
        .base = "BASE",
        .graphics_g4_dn = "GRAPHICS_G4DN",
        .graphics_g6 = "GRAPHICS_G6",
    };
};
