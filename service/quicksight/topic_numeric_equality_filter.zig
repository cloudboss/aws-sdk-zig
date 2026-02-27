const NamedFilterAggType = @import("named_filter_agg_type.zig").NamedFilterAggType;
const TopicSingularFilterConstant = @import("topic_singular_filter_constant.zig").TopicSingularFilterConstant;

/// A filter that filters topics based on the value of a numeric field. The
/// filter includes only topics whose numeric field value matches the specified
/// value.
pub const TopicNumericEqualityFilter = struct {
    /// An aggregation function that specifies how to calculate the value of a
    /// numeric field for
    /// a topic. Valid values for this structure are `NO_AGGREGATION`, `SUM`,
    /// `AVERAGE`, `COUNT`, `DISTINCT_COUNT`, `MAX`,
    /// `MEDIAN`, `MIN`, `STDEV`, `STDEVP`,
    /// `VAR`,
    /// and `VARP`.
    aggregation: ?NamedFilterAggType,

    /// The constant used in a numeric equality filter.
    constant: ?TopicSingularFilterConstant,

    pub const json_field_names = .{
        .aggregation = "Aggregation",
        .constant = "Constant",
    };
};
