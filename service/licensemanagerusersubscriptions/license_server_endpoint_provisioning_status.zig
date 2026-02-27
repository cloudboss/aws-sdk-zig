pub const LicenseServerEndpointProvisioningStatus = enum {
    provisioning,
    provisioning_failed,
    provisioned,
    deleting,
    deletion_failed,
    deleted,

    pub const json_field_names = .{
        .provisioning = "PROVISIONING",
        .provisioning_failed = "PROVISIONING_FAILED",
        .provisioned = "PROVISIONED",
        .deleting = "DELETING",
        .deletion_failed = "DELETION_FAILED",
        .deleted = "DELETED",
    };
};
