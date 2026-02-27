pub const SubscriptionStatus = enum {
    active,
    inactive,
    cancelled,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .inactive = "INACTIVE",
        .cancelled = "CANCELLED",
    };
};
