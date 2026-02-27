pub const ProvisioningType = enum {
    fleet_provisioning,
    jitr,

    pub const json_field_names = .{
        .fleet_provisioning = "FLEET_PROVISIONING",
        .jitr = "JITR",
    };
};
