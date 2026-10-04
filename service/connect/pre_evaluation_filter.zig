const PreEvaluationFilterType = @import("pre_evaluation_filter_type.zig").PreEvaluationFilterType;
const PreEvaluationFilterOperator = @import("pre_evaluation_filter_operator.zig").PreEvaluationFilterOperator;
const PreEvaluationFilterResourceType = @import("pre_evaluation_filter_resource_type.zig").PreEvaluationFilterResourceType;

/// A single pre-evaluation filter condition. Specifies a resource type, filter
/// type, key, value, and operator
/// to match against a resource attribute.
pub const PreEvaluationFilter = struct {
    /// The key of the attribute to filter on. For tag filters, this is the tag key.
    filter_key: []const u8,

    /// The type of filter to apply. Valid values: `TAG`.
    filter_type: PreEvaluationFilterType,

    /// The value to match against. For tag filters, this is the tag value.
    filter_value: []const u8,

    /// The comparison operator for the filter condition. Valid values: `EQUALS`.
    operator: PreEvaluationFilterOperator,

    /// The type of resource to filter on. Valid values: `CONTACT`.
    resource_type: PreEvaluationFilterResourceType,

    pub const json_field_names = .{
        .filter_key = "FilterKey",
        .filter_type = "FilterType",
        .filter_value = "FilterValue",
        .operator = "Operator",
        .resource_type = "ResourceType",
    };
};
