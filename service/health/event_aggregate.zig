/// The number of events of each issue type. Returned by the
/// [DescribeEventAggregates](https://docs.aws.amazon.com/health/latest/APIReference/API_DescribeEventAggregates.html) operation.
pub const EventAggregate = struct {
    /// The issue type for the associated count.
    aggregate_value: ?[]const u8 = null,

    /// The number of events of the associated issue type.
    count: i32 = 0,

    pub const json_field_names = .{
        .aggregate_value = "aggregateValue",
        .count = "count",
    };
};
