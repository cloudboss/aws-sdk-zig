pub const InventoryQueryOperatorType = enum {
    equal,
    not_equal,
    begin_with,
    less_than,
    greater_than,
    exists,

    pub const json_field_names = .{
        .equal = "EQUAL",
        .not_equal = "NOT_EQUAL",
        .begin_with = "BEGIN_WITH",
        .less_than = "LESS_THAN",
        .greater_than = "GREATER_THAN",
        .exists = "EXISTS",
    };
};
