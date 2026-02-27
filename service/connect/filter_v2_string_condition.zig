const FilterV2StringConditionComparisonOperator = @import("filter_v2_string_condition_comparison_operator.zig").FilterV2StringConditionComparisonOperator;

/// System defined filtering condition. For example, the NOT_EXISTS
/// StringCondition returns documents where the
/// field specified by FilterKey does not exist in the document.
///
/// When the NOT_EXISTS StringCondition is added to a FilterV2 object,
/// FilterValues must be null or empty.
pub const FilterV2StringCondition = struct {
    /// The string condition.
    comparison: ?FilterV2StringConditionComparisonOperator,

    pub const json_field_names = .{
        .comparison = "Comparison",
    };
};
