pub const DescribeWorkspacesPoolsFilterOperator = enum {
    equals,
    notequals,
    contains,
    notcontains,

    pub const json_field_names = .{
        .equals = "EQUALS",
        .notequals = "NOTEQUALS",
        .contains = "CONTAINS",
        .notcontains = "NOTCONTAINS",
    };
};
