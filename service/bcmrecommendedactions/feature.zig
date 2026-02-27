pub const Feature = enum {
    account,
    budgets,
    cost_anomaly_detection,
    cost_optimization_hub,
    free_tier,
    iam,
    payments,
    reservations,
    savings_plans,
    tax_settings,

    pub const json_field_names = .{
        .account = "ACCOUNT",
        .budgets = "BUDGETS",
        .cost_anomaly_detection = "COST_ANOMALY_DETECTION",
        .cost_optimization_hub = "COST_OPTIMIZATION_HUB",
        .free_tier = "FREE_TIER",
        .iam = "IAM",
        .payments = "PAYMENTS",
        .reservations = "RESERVATIONS",
        .savings_plans = "SAVINGS_PLANS",
        .tax_settings = "TAX_SETTINGS",
    };
};
