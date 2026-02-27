pub const RuleAction = enum {
    create_listing_change_set,
    create_subscription_request,

    pub const json_field_names = .{
        .create_listing_change_set = "CREATE_LISTING_CHANGE_SET",
        .create_subscription_request = "CREATE_SUBSCRIPTION_REQUEST",
    };
};
