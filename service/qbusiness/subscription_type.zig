pub const SubscriptionType = enum {
    q_lite,
    q_business,

    pub const json_field_names = .{
        .q_lite = "Q_LITE",
        .q_business = "Q_BUSINESS",
    };
};
