pub const QuoteChar = enum {
    quote,
    quillemet,
    single_quote,
    disabled,

    pub const json_field_names = .{
        .quote = "QUOTE",
        .quillemet = "QUILLEMET",
        .single_quote = "SINGLE_QUOTE",
        .disabled = "DISABLED",
    };
};
