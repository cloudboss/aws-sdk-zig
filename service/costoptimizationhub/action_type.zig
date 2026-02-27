pub const ActionType = enum {
    rightsize,
    stop,
    upgrade,
    purchase_savings_plans,
    purchase_reserved_instances,
    migrate_to_graviton,
    delete,
    scale_in,

    pub const json_field_names = .{
        .rightsize = "RIGHTSIZE",
        .stop = "STOP",
        .upgrade = "UPGRADE",
        .purchase_savings_plans = "PURCHASE_SAVINGS_PLANS",
        .purchase_reserved_instances = "PURCHASE_RESERVED_INSTANCES",
        .migrate_to_graviton = "MIGRATE_TO_GRAVITON",
        .delete = "DELETE",
        .scale_in = "SCALE_IN",
    };
};
