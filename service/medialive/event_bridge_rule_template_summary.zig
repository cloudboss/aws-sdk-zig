const aws = @import("aws");

const EventBridgeRuleTemplateEventType = @import("event_bridge_rule_template_event_type.zig").EventBridgeRuleTemplateEventType;

/// Placeholder documentation for EventBridgeRuleTemplateSummary
pub const EventBridgeRuleTemplateSummary = struct {
    /// An eventbridge rule template's ARN (Amazon Resource Name)
    arn: []const u8,

    created_at: i64,

    /// A resource's optional description.
    description: ?[]const u8 = null,

    /// The number of targets configured to send matching events.
    event_target_count: i32,

    event_type: EventBridgeRuleTemplateEventType,

    /// An eventbridge rule template group's id. AWS provided template groups have
    /// ids that start with `aws-`
    group_id: []const u8,

    /// An eventbridge rule template's id. AWS provided templates have ids that
    /// start with `aws-`
    id: []const u8,

    modified_at: ?i64 = null,

    /// A resource's name. Names must be unique within the scope of a resource type
    /// in a specific region.
    name: []const u8,

    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_at = "CreatedAt",
        .description = "Description",
        .event_target_count = "EventTargetCount",
        .event_type = "EventType",
        .group_id = "GroupId",
        .id = "Id",
        .modified_at = "ModifiedAt",
        .name = "Name",
        .tags = "Tags",
    };
};
