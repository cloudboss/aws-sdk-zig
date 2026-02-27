pub const MarketplaceSubscriptionOnboardingStatus = enum {
    no_subscription,
    not_complete,
    complete,

    pub const json_field_names = .{
        .no_subscription = "NO_SUBSCRIPTION",
        .not_complete = "NOT_COMPLETE",
        .complete = "COMPLETE",
    };
};
