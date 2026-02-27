pub const GreenFleetProvisioningAction = enum {
    discover_existing,
    copy_auto_scaling_group,

    pub const json_field_names = .{
        .discover_existing = "DISCOVER_EXISTING",
        .copy_auto_scaling_group = "COPY_AUTO_SCALING_GROUP",
    };
};
