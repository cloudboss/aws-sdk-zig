pub const RuleType = enum {
    binary_length,
    number_comparison,
    string_from_set,
    string_length,

    pub const json_field_names = .{
        .binary_length = "BINARY_LENGTH",
        .number_comparison = "NUMBER_COMPARISON",
        .string_from_set = "STRING_FROM_SET",
        .string_length = "STRING_LENGTH",
    };
};
