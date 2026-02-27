pub const InlineContentType = enum {
    byte,
    text,

    pub const json_field_names = .{
        .byte = "BYTE",
        .text = "TEXT",
    };
};
