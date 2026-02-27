pub const CapacityProviderStatus = enum {
    provisioning,
    active,
    deprovisioning,
    inactive,

    pub const json_field_names = .{
        .provisioning = "PROVISIONING",
        .active = "ACTIVE",
        .deprovisioning = "DEPROVISIONING",
        .inactive = "INACTIVE",
    };
};
