pub const PrivacyBudgetType = enum {
    differential_privacy,
    access_budget,

    pub const json_field_names = .{
        .differential_privacy = "DIFFERENTIAL_PRIVACY",
        .access_budget = "ACCESS_BUDGET",
    };
};
