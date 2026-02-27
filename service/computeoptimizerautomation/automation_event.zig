const EstimatedMonthlySavings = @import("estimated_monthly_savings.zig").EstimatedMonthlySavings;
const EventStatus = @import("event_status.zig").EventStatus;
const EventType = @import("event_type.zig").EventType;
const ResourceType = @import("resource_type.zig").ResourceType;

/// Contains information about an automation event.
pub const AutomationEvent = struct {
    /// The Amazon Web Services account ID associated with the automation event.
    account_id: ?[]const u8,

    /// The timestamp when the automation event completed.
    completed_timestamp: ?i64,

    /// The timestamp when the automation event was created.
    created_timestamp: ?i64,

    /// The estimated monthly cost savings associated with this automation event.
    estimated_monthly_savings: ?EstimatedMonthlySavings,

    /// A description of the automation event.
    event_description: ?[]const u8,

    /// The unique identifier for the automation event.
    event_id: ?[]const u8,

    /// The current status of the automation event.
    event_status: ?EventStatus,

    /// The reason for the current event status.
    event_status_reason: ?[]const u8,

    /// The type of automation event.
    event_type: ?EventType,

    /// The ID of the recommended action associated with this automation event.
    recommended_action_id: ?[]const u8,

    /// The Amazon Web Services Region where the automation event occurred.
    region: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the resource affected by the automation
    /// event.
    resource_arn: ?[]const u8,

    /// The ID of the resource affected by the automation event.
    resource_id: ?[]const u8,

    /// The type of resource affected by the automation event.
    resource_type: ?ResourceType,

    /// The ID of the automation rule that triggered this event.
    rule_id: ?[]const u8,

    pub const json_field_names = .{
        .account_id = "accountId",
        .completed_timestamp = "completedTimestamp",
        .created_timestamp = "createdTimestamp",
        .estimated_monthly_savings = "estimatedMonthlySavings",
        .event_description = "eventDescription",
        .event_id = "eventId",
        .event_status = "eventStatus",
        .event_status_reason = "eventStatusReason",
        .event_type = "eventType",
        .recommended_action_id = "recommendedActionId",
        .region = "region",
        .resource_arn = "resourceArn",
        .resource_id = "resourceId",
        .resource_type = "resourceType",
        .rule_id = "ruleId",
    };
};
