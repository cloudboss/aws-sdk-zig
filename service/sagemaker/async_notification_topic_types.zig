pub const AsyncNotificationTopicTypes = enum {
    success_notification_topic,
    error_notification_topic,

    pub const json_field_names = .{
        .success_notification_topic = "SUCCESS_NOTIFICATION_TOPIC",
        .error_notification_topic = "ERROR_NOTIFICATION_TOPIC",
    };
};
