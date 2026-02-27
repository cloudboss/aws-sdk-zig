const Filter = @import("filter.zig").Filter;

/// The search expression.
pub const SearchExpression = struct {
    /// The search expression filters.
    filters: []const Filter,

    pub const json_field_names = .{
        .filters = "filters",
    };
};
