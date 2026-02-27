pub const MapFilterComparison = enum {
    equals,
    not_equals,
    contains,
    not_contains,

    pub const json_field_names = .{
        .equals = "EQUALS",
        .not_equals = "NOT_EQUALS",
        .contains = "CONTAINS",
        .not_contains = "NOT_CONTAINS",
    };
};
