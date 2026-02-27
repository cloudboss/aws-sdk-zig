pub const FontDecoration = enum {
    underline,
    none,

    pub const json_field_names = .{
        .underline = "UNDERLINE",
        .none = "NONE",
    };
};
