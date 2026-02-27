pub const QueryIdentifiersEnclosingOption = enum {
    double_quotes,
    none,

    pub const json_field_names = .{
        .double_quotes = "DOUBLE_QUOTES",
        .none = "NONE",
    };
};
