pub const CharLengthSemantics = enum {
    default,
    char,
    byte,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .char = "CHAR",
        .byte = "BYTE",
    };
};
