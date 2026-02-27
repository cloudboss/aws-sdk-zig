const aws = @import("aws");

const NamedEntityAggType = @import("named_entity_agg_type.zig").NamedEntityAggType;

/// A structure that represents a metric.
pub const NamedEntityDefinitionMetric = struct {
    /// The aggregation of a named entity. Valid values for this structure are
    /// `SUM`,
    /// `MIN`, `MAX`, `COUNT`, `AVERAGE`,
    /// `DISTINCT_COUNT`, `STDEV`, `STDEVP`, `VAR`,
    /// `VARP`, `PERCENTILE`,
    /// `MEDIAN`,
    /// and `CUSTOM`.
    aggregation: ?NamedEntityAggType,

    /// The additional parameters for an aggregation function.
    aggregation_function_parameters: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .aggregation = "Aggregation",
        .aggregation_function_parameters = "AggregationFunctionParameters",
    };
};
