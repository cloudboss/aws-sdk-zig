pub const OciOnboardingStatus = enum {
    not_started,
    pending_link_generation,
    pending_customer_action,
    pending_initialization,
    activating,
    active_in_home_region,
    active,
    active_limited,
    failed,
    public_offer_unsupported,
    suspended,
    canceled,

    pub const json_field_names = .{
        .not_started = "NOT_STARTED",
        .pending_link_generation = "PENDING_LINK_GENERATION",
        .pending_customer_action = "PENDING_CUSTOMER_ACTION",
        .pending_initialization = "PENDING_INITIALIZATION",
        .activating = "ACTIVATING",
        .active_in_home_region = "ACTIVE_IN_HOME_REGION",
        .active = "ACTIVE",
        .active_limited = "ACTIVE_LIMITED",
        .failed = "FAILED",
        .public_offer_unsupported = "PUBLIC_OFFER_UNSUPPORTED",
        .suspended = "SUSPENDED",
        .canceled = "CANCELED",
    };
};
