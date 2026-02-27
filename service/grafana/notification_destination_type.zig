pub const NotificationDestinationType = enum {
    /// AWS Simple Notification Service
    sns,

    pub const json_field_names = .{
        .sns = "SNS",
    };
};
