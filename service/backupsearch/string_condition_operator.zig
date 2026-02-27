pub const StringConditionOperator = enum {
    equals_to,
    not_equals_to,
    contains,
    does_not_contain,
    begins_with,
    ends_with,
    does_not_begin_with,
    does_not_end_with,

    pub const json_field_names = .{
        .equals_to = "EQUALS_TO",
        .not_equals_to = "NOT_EQUALS_TO",
        .contains = "CONTAINS",
        .does_not_contain = "DOES_NOT_CONTAIN",
        .begins_with = "BEGINS_WITH",
        .ends_with = "ENDS_WITH",
        .does_not_begin_with = "DOES_NOT_BEGIN_WITH",
        .does_not_end_with = "DOES_NOT_END_WITH",
    };
};
