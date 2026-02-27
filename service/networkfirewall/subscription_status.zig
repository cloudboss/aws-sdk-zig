pub const SubscriptionStatus = enum {
    not_subscribed,
    subscribed,

    pub const json_field_names = .{
        .not_subscribed = "NOT_SUBSCRIBED",
        .subscribed = "SUBSCRIBED",
    };
};
