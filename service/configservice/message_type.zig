pub const MessageType = enum {
    configuration_item_change_notification,
    configuration_snapshot_delivery_completed,
    scheduled_notification,
    oversized_configuration_item_change_notification,

    pub const json_field_names = .{
        .configuration_item_change_notification = "ConfigurationItemChangeNotification",
        .configuration_snapshot_delivery_completed = "ConfigurationSnapshotDeliveryCompleted",
        .scheduled_notification = "ScheduledNotification",
        .oversized_configuration_item_change_notification = "OversizedConfigurationItemChangeNotification",
    };
};
