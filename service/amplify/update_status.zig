pub const UpdateStatus = enum {
    requesting_certificate,
    pending_verification,
    importing_custom_certificate,
    pending_deployment,
    awaiting_app_cname,
    update_complete,
    update_failed,

    pub const json_field_names = .{
        .requesting_certificate = "REQUESTING_CERTIFICATE",
        .pending_verification = "PENDING_VERIFICATION",
        .importing_custom_certificate = "IMPORTING_CUSTOM_CERTIFICATE",
        .pending_deployment = "PENDING_DEPLOYMENT",
        .awaiting_app_cname = "AWAITING_APP_CNAME",
        .update_complete = "UPDATE_COMPLETE",
        .update_failed = "UPDATE_FAILED",
    };
};
