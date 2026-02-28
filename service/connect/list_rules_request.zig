const EventSourceName = @import("event_source_name.zig").EventSourceName;
const RulePublishStatus = @import("rule_publish_status.zig").RulePublishStatus;

pub const ListRulesRequest = struct {
    /// The name of the event source.
    event_source_name: ?EventSourceName,

    /// The identifier of the Amazon Connect instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    /// The maximum number of results to return per page.
    max_results: ?i32,

    /// The token for the next set of results. Use the value returned in the
    /// previous
    /// response in the next request to retrieve the next set of results.
    next_token: ?[]const u8,

    /// The publish status of the rule.
    publish_status: ?RulePublishStatus,

    pub const json_field_names = .{
        .event_source_name = "EventSourceName",
        .instance_id = "InstanceId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .publish_status = "PublishStatus",
    };
};
