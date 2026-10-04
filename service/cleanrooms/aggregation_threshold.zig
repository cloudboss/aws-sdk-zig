const AllowedAggregateExpressionType = @import("allowed_aggregate_expression_type.zig").AllowedAggregateExpressionType;
const OutputColumnThreshold = @import("output_column_threshold.zig").OutputColumnThreshold;
const AggregationThresholdType = @import("aggregation_threshold_type.zig").AggregationThresholdType;

/// Specifies the minimum number of distinct identities that each query output
/// group must represent.
pub const AggregationThreshold = struct {
    /// Specifies whether a query can aggregate a transformed column. This applies
    /// to the arguments of both aggregate and window functions. Valid values are:
    ///
    /// `COLUMNS_ONLY` – A query can aggregate only a direct column reference, such
    /// as `SUM(amount)`, or a constant. Clean Rooms rejects a query that transforms
    /// a column and then aggregates it, such as `SUM(amount * 2)` or
    /// `SUM(ROUND(amount))`.
    ///
    /// `ANY_EXPRESSION` – A query can aggregate any expression. This includes
    /// arithmetic, such as `SUM(price * quantity)`; a cast, such as
    /// `SUM(CAST(amount AS DECIMAL))`; a nested function call, such as
    /// `SUM(COALESCE(amount, 0))`; and a conditional, such as `SUM(CASE WHEN region
    /// = 'EU' THEN amount ELSE 0 END)`.
    allowed_aggregate_expression_type: AllowedAggregateExpressionType,

    /// The identity column, such as `user_id`, whose distinct values Clean Rooms
    /// counts to enforce minimum aggregation thresholds. Currently, you can specify
    /// only one column, and its data type must be string, varchar, or char.
    identity_columns: []const []const u8,

    /// The minimum number of distinct identities that each query output group must
    /// represent. This threshold applies to all output columns in the table. To
    /// override this threshold for a specific column, use `outputColumnThresholds`.
    minimum_identity_count: i32,

    /// The per-column overrides of `minimumIdentityCount`. An output column without
    /// an override uses `minimumIdentityCount`.
    output_column_thresholds: ?[]const OutputColumnThreshold = null,

    /// The type of aggregation that the threshold enforces. Currently, the only
    /// supported value is `COUNT_DISTINCT`, which counts the distinct values in the
    /// identity column.
    @"type": AggregationThresholdType,

    pub const json_field_names = .{
        .allowed_aggregate_expression_type = "allowedAggregateExpressionType",
        .identity_columns = "identityColumns",
        .minimum_identity_count = "minimumIdentityCount",
        .output_column_thresholds = "outputColumnThresholds",
        .@"type" = "type",
    };
};
