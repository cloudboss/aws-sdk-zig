const AggFunction = @import("agg_function.zig").AggFunction;

/// Specifies the set of parameters needed to perform aggregation in the
/// aggregate transform.
pub const AggregateOperation = struct {
    /// Specifies the aggregation function to apply.
    ///
    /// Possible aggregation functions include: avg countDistinct, count, first,
    /// last, kurtosis, max, min, skewness,
    /// stddev_samp, stddev_pop, sum, sumDistinct, var_samp, var_pop
    agg_func: AggFunction,

    /// Specifies the column on the data set on which the aggregation function will
    /// be applied.
    column: []const []const u8,

    pub const json_field_names = .{
        .agg_func = "AggFunc",
        .column = "Column",
    };
};
