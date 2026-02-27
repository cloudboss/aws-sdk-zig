pub const OrganizationConfigRuleTriggerType = enum {
    configuration_item_change_notification,
    oversized_configuration_item_change_notifcation,
    scheduled_notification,

    pub const json_field_names = .{
        .configuration_item_change_notification = "CONFIGURATION_ITEM_CHANGE_NOTIFICATION",
        .oversized_configuration_item_change_notifcation = "OVERSIZED_CONFIGURATION_ITEM_CHANGE_NOTIFCATION",
        .scheduled_notification = "SCHEDULED_NOTIFICATION",
    };
};
