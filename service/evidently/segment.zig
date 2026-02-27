const aws = @import("aws");

/// This structure contains information about one audience *segment*. You can
/// use segments in your experiments and launches to narrow the user sessions
/// used for experiment or launch to only the user sessions that match one or
/// more criteria.
pub const Segment = struct {
    /// The ARN of the segment.
    arn: []const u8,

    /// The date and time that this segment was created.
    created_time: i64,

    /// The customer-created description for this segment.
    description: ?[]const u8,

    /// The number of experiments that this segment is used in. This count includes
    /// all current experiments, not just those that are currently running.
    experiment_count: ?i64,

    /// The date and time that this segment was most recently updated.
    last_updated_time: i64,

    /// The number of launches that this segment is used in. This count includes all
    /// current launches, not just those that are currently running.
    launch_count: ?i64,

    /// The name of the segment.
    name: []const u8,

    /// The pattern that defines the attributes to use to evalute whether a user
    /// session will be in the segment. For more information about the pattern
    /// syntax, see [Segment rule pattern
    /// syntax](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Evidently-segments.html).
    pattern: []const u8,

    /// The list of tag keys and values associated with this launch.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .arn = "arn",
        .created_time = "createdTime",
        .description = "description",
        .experiment_count = "experimentCount",
        .last_updated_time = "lastUpdatedTime",
        .launch_count = "launchCount",
        .name = "name",
        .pattern = "pattern",
        .tags = "tags",
    };
};
