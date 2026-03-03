const ResourcesTrendsCompositeFilter = @import("resources_trends_composite_filter.zig").ResourcesTrendsCompositeFilter;
const AllowedOperators = @import("allowed_operators.zig").AllowedOperators;

/// The structure that defines filters to apply to resources trend data queries.
pub const ResourcesTrendsFilters = struct {
    /// A list of composite filters to apply to the resources trend data.
    composite_filters: ?[]const ResourcesTrendsCompositeFilter = null,

    /// The logical operator (AND, OR) to apply between multiple composite filters.
    composite_operator: ?AllowedOperators = null,

    pub const json_field_names = .{
        .composite_filters = "CompositeFilters",
        .composite_operator = "CompositeOperator",
    };
};
