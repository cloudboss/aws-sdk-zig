pub const BoxPlotFillStyle = enum {
    solid,
    transparent,

    pub const json_field_names = .{
        .solid = "SOLID",
        .transparent = "TRANSPARENT",
    };
};
