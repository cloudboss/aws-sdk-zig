pub const ValidationStrategyMode = enum {
    strict,
    lenient,

    pub const json_field_names = .{
        .strict = "STRICT",
        .lenient = "LENIENT",
    };
};
