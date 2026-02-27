const Filter = @import("filter.zig").Filter;

/// A search filter clause in Amazon DataZone.
pub const FilterClause = union(enum) {
    /// The 'and' search filter clause in Amazon DataZone.
    @"and": ?[]const FilterClause,
    /// A search filter in Amazon DataZone.
    filter: ?Filter,
    /// The 'or' search filter clause in Amazon DataZone.
    @"or": ?[]const FilterClause,

    pub const json_field_names = .{
        .@"and" = "and",
        .filter = "filter",
        .@"or" = "or",
    };
};
