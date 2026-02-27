pub const MatchOption = enum {
    equals,
    starts_with,
    contains,

    pub const json_field_names = .{
        .equals = "EQUALS",
        .starts_with = "STARTS_WITH",
        .contains = "CONTAINS",
    };
};
