const QueryTemporalRangeMax = @import("query_temporal_range_max.zig").QueryTemporalRangeMax;

/// Provides insights into the temporal range of the query, including the table
/// with the largest (max) time range.
pub const QueryTemporalRange = struct {
    /// Encapsulates the following properties that provide insights into the most
    /// sub-optimal performing table on the temporal axis:
    ///
    /// * `Value` – The maximum duration in nanoseconds between the start and end of
    ///   the query.
    ///
    /// * `TableArn` – The Amazon Resource Name (ARN) of the table which is queried
    ///   with the largest time range.
    max: ?QueryTemporalRangeMax = null,

    pub const json_field_names = .{
        .max = "Max",
    };
};
