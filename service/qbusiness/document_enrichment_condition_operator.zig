pub const DocumentEnrichmentConditionOperator = enum {
    greater_than,
    greater_than_or_equals,
    less_than,
    less_than_or_equals,
    equals,
    not_equals,
    contains,
    not_contains,
    exists,
    not_exists,
    begins_with,

    pub const json_field_names = .{
        .greater_than = "GREATER_THAN",
        .greater_than_or_equals = "GREATER_THAN_OR_EQUALS",
        .less_than = "LESS_THAN",
        .less_than_or_equals = "LESS_THAN_OR_EQUALS",
        .equals = "EQUALS",
        .not_equals = "NOT_EQUALS",
        .contains = "CONTAINS",
        .not_contains = "NOT_CONTAINS",
        .exists = "EXISTS",
        .not_exists = "NOT_EXISTS",
        .begins_with = "BEGINS_WITH",
    };
};
