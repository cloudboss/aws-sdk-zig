pub const WorkerType = enum {
    standard,
    g_1_x,
    g_2_x,
    g_025_x,
    g_4_x,
    g_8_x,
    z_2_x,

    pub const json_field_names = .{
        .standard = "Standard",
        .g_1_x = "G_1X",
        .g_2_x = "G_2X",
        .g_025_x = "G_025X",
        .g_4_x = "G_4X",
        .g_8_x = "G_8X",
        .z_2_x = "Z_2X",
    };
};
