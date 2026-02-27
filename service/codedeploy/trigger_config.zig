const TriggerEventType = @import("trigger_event_type.zig").TriggerEventType;

/// Information about notification triggers for the deployment group.
pub const TriggerConfig = struct {
    /// The event type or types for which notifications are triggered.
    trigger_events: ?[]const TriggerEventType,

    /// The name of the notification trigger.
    trigger_name: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the Amazon Simple Notification Service
    /// topic through
    /// which notifications about deployment or instance events are sent.
    trigger_target_arn: ?[]const u8,

    pub const json_field_names = .{
        .trigger_events = "triggerEvents",
        .trigger_name = "triggerName",
        .trigger_target_arn = "triggerTargetArn",
    };
};
