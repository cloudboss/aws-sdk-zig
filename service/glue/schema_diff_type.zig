pub const SchemaDiffType = enum {
    syntax_diff,

    pub const json_field_names = .{
        .syntax_diff = "SYNTAX_DIFF",
    };
};
