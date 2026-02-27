pub const EcsClusterStatus = enum {
    active,
    provisioning,
    deprovisioning,
    failed,
    inactive,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .provisioning = "PROVISIONING",
        .deprovisioning = "DEPROVISIONING",
        .failed = "FAILED",
        .inactive = "INACTIVE",
    };
};
