pub const NotificationConfigurationStatus = enum {
    /// All of the EventRules are in ACTIVE Status. Any call can be executed.
    active,
    /// Some EventRules are in ACTIVE Status and some are INACTIVE. Any call can be
    /// executed.
    partially_active,
    /// All of the EventRules are in INACTIVE Status. Any call can be executed.
    inactive,
    /// This NotificationConfiguration is being deleted. Only GET/LIST calls can be
    /// executed.
    deleting,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .partially_active = "PARTIALLY_ACTIVE",
        .inactive = "INACTIVE",
        .deleting = "DELETING",
    };
};
