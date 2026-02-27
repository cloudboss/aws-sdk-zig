const NamedFilterAggType = @import("named_filter_agg_type.zig").NamedFilterAggType;
const TopicRangeFilterConstant = @import("topic_range_filter_constant.zig").TopicRangeFilterConstant;

/// A filter that filters topics based on the value of a numeric field. The
/// filter includes only topics whose numeric field value falls within the
/// specified range.
pub const TopicNumericRangeFilter = struct {
    /// An aggregation function that specifies how to calculate the value of a
    /// numeric field for
    /// a topic, Valid values for this structure are `NO_AGGREGATION`, `SUM`,
    /// `AVERAGE`, `COUNT`, `DISTINCT_COUNT`, `MAX`,
    /// `MEDIAN`, `MIN`, `STDEV`, `STDEVP`,
    /// `VAR`,
    /// and `VARP`.
    aggregation: ?NamedFilterAggType,

    /// The constant used in a
    /// numeric range filter.
    constant: ?TopicRangeFilterConstant,

    /// A Boolean value that indicates whether the endpoints of the numeric range
    /// are included in the filter.
    /// If set to true, topics whose numeric field value is equal to the endpoint
    /// values will be
    /// included in the filter. If set to false, topics whose numeric field value is
    /// equal to the
    /// endpoint values will be excluded from the filter.
    inclusive: bool = false,

    pub const json_field_names = .{
        .aggregation = "Aggregation",
        .constant = "Constant",
        .inclusive = "Inclusive",
    };
};
