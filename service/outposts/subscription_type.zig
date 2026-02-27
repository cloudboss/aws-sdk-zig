pub const SubscriptionType = enum {
    original,
    renewal,
    capacity_increase,

    pub const json_field_names = .{
        .original = "ORIGINAL",
        .renewal = "RENEWAL",
        .capacity_increase = "CAPACITY_INCREASE",
    };
};
