pub const ProvisionedProductStatus = enum {
    available,
    under_change,
    tainted,
    @"error",
    plan_in_progress,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .under_change = "UNDER_CHANGE",
        .tainted = "TAINTED",
        .@"error" = "ERROR",
        .plan_in_progress = "PLAN_IN_PROGRESS",
    };
};
