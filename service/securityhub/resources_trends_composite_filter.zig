const AllowedOperators = @import("allowed_operators.zig").AllowedOperators;
const ResourcesTrendsStringFilter = @import("resources_trends_string_filter.zig").ResourcesTrendsStringFilter;

/// A filter structure that contains a logical combination of string filters and
/// nested composite filters for resources trend data.
pub const ResourcesTrendsCompositeFilter = struct {
    /// A list of nested composite filters that you can use to create complex filter
    /// conditions for resources trend data.
    nested_composite_filters: ?[]const ResourcesTrendsCompositeFilter,

    /// The logical operator (AND, OR) to apply between the string filters and
    /// nested composite filters.
    operator: ?AllowedOperators,

    /// A list of string filters that apply to resources trend data fields.
    string_filters: ?[]const ResourcesTrendsStringFilter,

    pub const json_field_names = .{
        .nested_composite_filters = "NestedCompositeFilters",
        .operator = "Operator",
        .string_filters = "StringFilters",
    };
};
