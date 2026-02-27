pub const NegativeValueDisplayMode = enum {
    positive,
    negative,

    pub const json_field_names = .{
        .positive = "POSITIVE",
        .negative = "NEGATIVE",
    };
};
