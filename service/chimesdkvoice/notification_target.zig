pub const NotificationTarget = enum {
    event_bridge,
    sns,
    sqs,

    pub const json_field_names = .{
        .event_bridge = "EventBridge",
        .sns = "SNS",
        .sqs = "SQS",
    };
};
