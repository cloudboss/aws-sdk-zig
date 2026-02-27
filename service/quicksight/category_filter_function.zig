pub const CategoryFilterFunction = enum {
    exact,
    contains,

    pub const json_field_names = .{
        .exact = "EXACT",
        .contains = "CONTAINS",
    };
};
