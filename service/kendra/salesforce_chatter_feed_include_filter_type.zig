pub const SalesforceChatterFeedIncludeFilterType = enum {
    active_user,
    standard_user,

    pub const json_field_names = .{
        .active_user = "ACTIVE_USER",
        .standard_user = "STANDARD_USER",
    };
};
