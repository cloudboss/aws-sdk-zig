pub const FontStyle = enum {
    normal,
    italic,

    pub const json_field_names = .{
        .normal = "NORMAL",
        .italic = "ITALIC",
    };
};
