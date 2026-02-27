pub const ColorScheme = enum {
    light,
    dark,

    pub const json_field_names = .{
        .light = "LIGHT",
        .dark = "DARK",
    };
};
