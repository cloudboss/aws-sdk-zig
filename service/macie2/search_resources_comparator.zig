/// The operator to use in a condition that filters the results of a query.
/// Valid values are:
pub const SearchResourcesComparator = enum {
    eq,
    ne,

    pub const json_field_names = .{
        .eq = "EQ",
        .ne = "NE",
    };
};
