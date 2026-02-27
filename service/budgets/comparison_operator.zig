/// The comparison operator of a notification. Currently, the service supports
/// the
/// following operators:
///
/// `GREATER_THAN`, `LESS_THAN`, `EQUAL_TO`
pub const ComparisonOperator = enum {
    greater_than,
    less_than,
    equal_to,

    pub const json_field_names = .{
        .greater_than = "GREATER_THAN",
        .less_than = "LESS_THAN",
        .equal_to = "EQUAL_TO",
    };
};
