pub const FontWeightName = enum {
    normal,
    bold,

    pub const json_field_names = .{
        .normal = "NORMAL",
        .bold = "BOLD",
    };
};
