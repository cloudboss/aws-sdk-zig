pub const ComparisonOperator = enum {
    less_than,
    less_than_equals,
    greater_than,
    greater_than_equals,
    in_cidr_set,
    not_in_cidr_set,
    in_port_set,
    not_in_port_set,
    in_set,
    not_in_set,

    pub const json_field_names = .{
        .less_than = "LESS_THAN",
        .less_than_equals = "LESS_THAN_EQUALS",
        .greater_than = "GREATER_THAN",
        .greater_than_equals = "GREATER_THAN_EQUALS",
        .in_cidr_set = "IN_CIDR_SET",
        .not_in_cidr_set = "NOT_IN_CIDR_SET",
        .in_port_set = "IN_PORT_SET",
        .not_in_port_set = "NOT_IN_PORT_SET",
        .in_set = "IN_SET",
        .not_in_set = "NOT_IN_SET",
    };
};
