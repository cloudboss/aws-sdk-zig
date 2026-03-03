const AllowedOperators = @import("allowed_operators.zig").AllowedOperators;
const FindingsTrendsStringFilter = @import("findings_trends_string_filter.zig").FindingsTrendsStringFilter;

/// A filter structure that contains a logical combination of string filters and
/// nested composite filters for findings trend data.
pub const FindingsTrendsCompositeFilter = struct {
    /// A list of nested composite filters that you can use to create complex filter
    /// conditions for findings trend data.
    nested_composite_filters: ?[]const FindingsTrendsCompositeFilter = null,

    /// The logical operator (AND, OR) to apply between the string filters and
    /// nested composite filters.
    operator: ?AllowedOperators = null,

    /// A list of string filters that apply to findings trend data fields.
    string_filters: ?[]const FindingsTrendsStringFilter = null,

    pub const json_field_names = .{
        .nested_composite_filters = "NestedCompositeFilters",
        .operator = "Operator",
        .string_filters = "StringFilters",
    };
};
