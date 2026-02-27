pub const AnomalySubscriptionFrequency = enum {
    daily,
    immediate,
    weekly,

    pub const json_field_names = .{
        .daily = "DAILY",
        .immediate = "IMMEDIATE",
        .weekly = "WEEKLY",
    };
};
