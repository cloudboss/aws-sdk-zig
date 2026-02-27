pub const ProvisioningStatus = enum {
    latest_permission_set_provisioned,
    latest_permission_set_not_provisioned,

    pub const json_field_names = .{
        .latest_permission_set_provisioned = "LATEST_PERMISSION_SET_PROVISIONED",
        .latest_permission_set_not_provisioned = "LATEST_PERMISSION_SET_NOT_PROVISIONED",
    };
};
