pub const FilterV2StringConditionComparisonOperator = enum {
    not_exists,

    pub const json_field_names = .{
        .not_exists = "NOT_EXISTS",
    };
};
