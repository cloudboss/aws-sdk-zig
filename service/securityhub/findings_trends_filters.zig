const FindingsTrendsCompositeFilter = @import("findings_trends_composite_filter.zig").FindingsTrendsCompositeFilter;
const AllowedOperators = @import("allowed_operators.zig").AllowedOperators;

/// The structure that defines filters to apply to findings trend data queries.
pub const FindingsTrendsFilters = struct {
    /// A list of composite filters to apply to the findings trend data.
    composite_filters: ?[]const FindingsTrendsCompositeFilter = null,

    /// The logical operator (AND, OR) to apply between multiple composite filters.
    composite_operator: ?AllowedOperators = null,

    pub const json_field_names = .{
        .composite_filters = "CompositeFilters",
        .composite_operator = "CompositeOperator",
    };
};
