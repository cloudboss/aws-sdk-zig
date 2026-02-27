pub const BotFilterOperator = enum {
    contains,
    equals,
    not_equals,

    pub const json_field_names = .{
        .contains = "Contains",
        .equals = "Equals",
        .not_equals = "NotEquals",
    };
};
