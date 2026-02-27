pub const AggregatedUtterancesFilterOperator = enum {
    contains,
    equals,

    pub const json_field_names = .{
        .contains = "Contains",
        .equals = "Equals",
    };
};
