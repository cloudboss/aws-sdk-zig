pub const IdentitySourceStatusCode = enum {
    access_denied,
    deletion_failed,
    idc_instance_not_found,
    idc_instance_not_valid,

    pub const json_field_names = .{
        .access_denied = "ACCESS_DENIED",
        .deletion_failed = "DELETION_FAILED",
        .idc_instance_not_found = "IDC_INSTANCE_NOT_FOUND",
        .idc_instance_not_valid = "IDC_INSTANCE_NOT_VALID",
    };
};
