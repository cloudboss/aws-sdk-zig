pub const LineTerminator = enum {
    crlf,
    lf,
    cr,

    pub const json_field_names = .{
        .crlf = "CRLF",
        .lf = "LF",
        .cr = "CR",
    };
};
