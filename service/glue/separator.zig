pub const Separator = enum {
    comma,
    ctrla,
    pipe,
    semicolon,
    tab,

    pub const json_field_names = .{
        .comma = "COMMA",
        .ctrla = "CTRLA",
        .pipe = "PIPE",
        .semicolon = "SEMICOLON",
        .tab = "TAB",
    };
};
