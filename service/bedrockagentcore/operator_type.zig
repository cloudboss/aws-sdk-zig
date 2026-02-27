pub const OperatorType = enum {
    equals_to,
    exists,
    not_exists,

    pub const json_field_names = .{
        .equals_to = "EQUALS_TO",
        .exists = "EXISTS",
        .not_exists = "NOT_EXISTS",
    };
};
