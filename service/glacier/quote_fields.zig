pub const QuoteFields = enum {
    always,
    as_needed,

    pub const json_field_names = .{
        .always = "Always",
        .as_needed = "AsNeeded",
    };
};
