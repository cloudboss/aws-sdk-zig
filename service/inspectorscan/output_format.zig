pub const OutputFormat = enum {
    cyclone_dx_1_5,
    inspector,
    inspector_alt,

    pub const json_field_names = .{
        .cyclone_dx_1_5 = "CYCLONE_DX_1_5",
        .inspector = "INSPECTOR",
        .inspector_alt = "INSPECTOR_ALT",
    };
};
