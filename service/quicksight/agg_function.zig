const aws = @import("aws");

const AggType = @import("agg_type.zig").AggType;
const TopicTimeGranularity = @import("topic_time_granularity.zig").TopicTimeGranularity;

/// The definition of an Agg function.
pub const AggFunction = struct {
    /// The aggregation of an Agg function.
    aggregation: ?AggType,

    /// The aggregation parameters for an Agg function.
    aggregation_function_parameters: ?[]const aws.map.StringMapEntry,

    /// The period of an Agg function.
    period: ?TopicTimeGranularity,

    /// The period field for an Agg function.
    period_field: ?[]const u8,

    pub const json_field_names = .{
        .aggregation = "Aggregation",
        .aggregation_function_parameters = "AggregationFunctionParameters",
        .period = "Period",
        .period_field = "PeriodField",
    };
};
