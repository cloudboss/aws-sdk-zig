const aws = @import("aws");

const DateTimeRange = @import("date_time_range.zig").DateTimeRange;
const entityStatusCode = @import("entity_status_code.zig").entityStatusCode;

/// The values to use to filter results from the
/// [DescribeAffectedEntities](https://docs.aws.amazon.com/health/latest/APIReference/API_DescribeAffectedEntities.html) operation.
pub const EntityFilter = struct {
    /// A list of entity ARNs (unique identifiers).
    entity_arns: ?[]const []const u8,

    /// A list of IDs for affected entities.
    entity_values: ?[]const []const u8,

    /// A list of event ARNs (unique identifiers). For example:
    /// `"arn:aws:health:us-east-1::event/EC2/EC2_INSTANCE_RETIREMENT_SCHEDULED/EC2_INSTANCE_RETIREMENT_SCHEDULED_ABC123-CDE456", "arn:aws:health:us-west-1::event/EBS/AWS_EBS_LOST_VOLUME/AWS_EBS_LOST_VOLUME_CHI789_JKL101"`
    event_arns: []const []const u8,

    /// A list of the most recent dates and times that the entity was updated.
    last_updated_times: ?[]const DateTimeRange,

    /// A list of entity status codes (`IMPAIRED`, `UNIMPAIRED`, or
    /// `UNKNOWN`).
    status_codes: ?[]const entityStatusCode,

    /// A map of entity tags attached to the affected entity.
    ///
    /// Currently, the `tags` property isn't supported.
    tags: ?[]const []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .entity_arns = "entityArns",
        .entity_values = "entityValues",
        .event_arns = "eventArns",
        .last_updated_times = "lastUpdatedTimes",
        .status_codes = "statusCodes",
        .tags = "tags",
    };
};
