const TimeGranularity = @import("time_granularity.zig").TimeGranularity;

/// The definition of an `AggregationPartitionBy`.
pub const AggregationPartitionBy = struct {
    /// The field Name for an `AggregationPartitionBy`.
    field_name: ?[]const u8 = null,

    /// The `TimeGranularity` for an `AggregationPartitionBy`.
    time_granularity: ?TimeGranularity = null,

    pub const json_field_names = .{
        .field_name = "FieldName",
        .time_granularity = "TimeGranularity",
    };
};
