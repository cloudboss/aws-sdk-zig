pub const QueryParser = enum {
    simple,
    structured,
    lucene,
    dismax,

    pub const json_field_names = .{
        .simple = "simple",
        .structured = "structured",
        .lucene = "lucene",
        .dismax = "dismax",
    };
};
