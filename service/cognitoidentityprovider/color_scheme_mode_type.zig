pub const ColorSchemeModeType = enum {
    light,
    dark,
    dynamic,

    pub const json_field_names = .{
        .light = "LIGHT",
        .dark = "DARK",
        .dynamic = "DYNAMIC",
    };
};
