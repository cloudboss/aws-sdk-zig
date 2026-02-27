pub const PositionalConstraint = enum {
    exactly,
    starts_with,
    ends_with,
    contains,
    contains_word,

    pub const json_field_names = .{
        .exactly = "EXACTLY",
        .starts_with = "STARTS_WITH",
        .ends_with = "ENDS_WITH",
        .contains = "CONTAINS",
        .contains_word = "CONTAINS_WORD",
    };
};
