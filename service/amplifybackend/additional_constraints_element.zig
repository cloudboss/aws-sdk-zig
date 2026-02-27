pub const AdditionalConstraintsElement = enum {
    require_digit,
    require_lowercase,
    require_symbol,
    require_uppercase,

    pub const json_field_names = .{
        .require_digit = "REQUIRE_DIGIT",
        .require_lowercase = "REQUIRE_LOWERCASE",
        .require_symbol = "REQUIRE_SYMBOL",
        .require_uppercase = "REQUIRE_UPPERCASE",
    };
};
