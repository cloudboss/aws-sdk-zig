pub const FormatToHeaderKey = enum {
    chr,
    start,
    end,
    ref,
    alt,
    pos,

    pub const json_field_names = .{
        .chr = "CHR",
        .start = "START",
        .end = "END",
        .ref = "REF",
        .alt = "ALT",
        .pos = "POS",
    };
};
