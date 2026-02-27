const DifferentialPrivacyAggregationType = @import("differential_privacy_aggregation_type.zig").DifferentialPrivacyAggregationType;

/// Information about the total number of aggregations, as well as the remaining
/// aggregations.
pub const DifferentialPrivacyPrivacyBudgetAggregation = struct {
    /// The maximum number of aggregation functions that you can perform with the
    /// given privacy budget.
    max_count: i32,

    /// The remaining number of aggregation functions that can be run with the
    /// available privacy budget.
    remaining_count: i32,

    /// The different types of aggregation functions that you can perform.
    @"type": DifferentialPrivacyAggregationType,

    pub const json_field_names = .{
        .max_count = "maxCount",
        .remaining_count = "remainingCount",
        .@"type" = "type",
    };
};
