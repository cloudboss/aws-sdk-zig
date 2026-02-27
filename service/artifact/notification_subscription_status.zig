pub const NotificationSubscriptionStatus = enum {
    subscribed,
    not_subscribed,

    pub const json_field_names = .{
        .subscribed = "SUBSCRIBED",
        .not_subscribed = "NOT_SUBSCRIBED",
    };
};
