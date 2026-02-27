pub const WrapFormat = enum {
    segment,
    one_line,
    line_length,

    pub const json_field_names = .{
        .segment = "SEGMENT",
        .one_line = "ONE_LINE",
        .line_length = "LINE_LENGTH",
    };
};
