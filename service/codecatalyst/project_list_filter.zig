const ComparisonOperator = @import("comparison_operator.zig").ComparisonOperator;
const FilterKey = @import("filter_key.zig").FilterKey;

/// nformation about the filter used to narrow the results returned in a list of
/// projects.
pub const ProjectListFilter = struct {
    /// The operator used to compare the fields.
    comparison_operator: ?ComparisonOperator = null,

    /// A key that can be used to sort results.
    key: FilterKey,

    /// The values of the key.
    values: []const []const u8,

    pub const json_field_names = .{
        .comparison_operator = "comparisonOperator",
        .key = "key",
        .values = "values",
    };
};
