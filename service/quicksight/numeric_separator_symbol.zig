pub const NumericSeparatorSymbol = enum {
    comma,
    dot,
    space,

    pub const json_field_names = .{
        .comma = "COMMA",
        .dot = "DOT",
        .space = "SPACE",
    };
};
