pub const ManagedResourceStatus = enum {
    provisioning,
    active,
    deprovisioning,
    deleted,
    failed,

    pub const json_field_names = .{
        .provisioning = "PROVISIONING",
        .active = "ACTIVE",
        .deprovisioning = "DEPROVISIONING",
        .deleted = "DELETED",
        .failed = "FAILED",
    };
};
