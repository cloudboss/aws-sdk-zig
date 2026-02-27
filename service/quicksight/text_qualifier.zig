pub const TextQualifier = enum {
    double_quote,
    single_quote,

    pub const json_field_names = .{
        .double_quote = "DOUBLE_QUOTE",
        .single_quote = "SINGLE_QUOTE",
    };
};
