pub const InventoryFilterCondition = enum {
    equals,
    not_equals,
    begins_with,
    contains,

    pub const json_field_names = .{
        .equals = "EQUALS",
        .not_equals = "NOT_EQUALS",
        .begins_with = "BEGINS_WITH",
        .contains = "CONTAINS",
    };
};
