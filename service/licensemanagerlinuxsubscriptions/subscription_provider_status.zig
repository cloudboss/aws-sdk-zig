pub const SubscriptionProviderStatus = enum {
    /// ACTIVE status
    active,
    /// INVALID status
    invalid,
    /// PENDING status
    pending,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .invalid = "INVALID",
        .pending = "PENDING",
    };
};
