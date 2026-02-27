pub const BlockType = enum {
    line,
    word,

    pub const json_field_names = .{
        .line = "LINE",
        .word = "WORD",
    };
};
