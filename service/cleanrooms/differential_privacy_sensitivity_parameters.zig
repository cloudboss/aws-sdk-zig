const DifferentialPrivacyAggregationType = @import("differential_privacy_aggregation_type.zig").DifferentialPrivacyAggregationType;

/// Provides the sensitivity parameters.
pub const DifferentialPrivacySensitivityParameters = struct {
    /// The aggregation expression that was run.
    aggregation_expression: []const u8,

    /// The type of aggregation function that was run.
    aggregation_type: DifferentialPrivacyAggregationType,

    /// The upper bound of the aggregation expression.
    max_column_value: ?f32,

    /// The lower bound of the aggregation expression.
    min_column_value: ?f32,

    /// The maximum number of rows contributed by a user in a SQL query.
    user_contribution_limit: i32,

    pub const json_field_names = .{
        .aggregation_expression = "aggregationExpression",
        .aggregation_type = "aggregationType",
        .max_column_value = "maxColumnValue",
        .min_column_value = "minColumnValue",
        .user_contribution_limit = "userContributionLimit",
    };
};
