pub const Domain = enum {
    retail,
    custom,
    inventory_planning,
    ec2_capacity,
    work_force,
    web_traffic,
    metrics,

    pub const json_field_names = .{
        .retail = "RETAIL",
        .custom = "CUSTOM",
        .inventory_planning = "INVENTORY_PLANNING",
        .ec2_capacity = "EC2_CAPACITY",
        .work_force = "WORK_FORCE",
        .web_traffic = "WEB_TRAFFIC",
        .metrics = "METRICS",
    };
};
