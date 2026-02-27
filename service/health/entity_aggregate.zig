const aws = @import("aws");

/// The number of entities that are affected by one or more events. Returned by
/// the
/// [DescribeEntityAggregates](https://docs.aws.amazon.com/health/latest/APIReference/API_DescribeEntityAggregates.html) operation.
pub const EntityAggregate = struct {
    /// The number of entities that match the criteria for the specified events.
    count: i32 = 0,

    /// The unique identifier for the event. The event ARN has the
    /// `arn:aws:health:*event-region*::event/*SERVICE*/*EVENT_TYPE_CODE*/*EVENT_TYPE_PLUS_ID*
    /// `
    /// format.
    ///
    /// For example, an event ARN might look like the following:
    ///
    /// `arn:aws:health:us-east-1::event/EC2/EC2_INSTANCE_RETIREMENT_SCHEDULED/EC2_INSTANCE_RETIREMENT_SCHEDULED_ABC123-DEF456`
    event_arn: ?[]const u8,

    /// The number of affected entities aggregated by the entity status codes.
    statuses: ?[]const aws.map.MapEntry(i32),

    pub const json_field_names = .{
        .count = "count",
        .event_arn = "eventArn",
        .statuses = "statuses",
    };
};
