pub const DomainStatus = enum {
    pending_verification,
    in_progress,
    available,
    importing_custom_certificate,
    pending_deployment,
    awaiting_app_cname,
    failed,
    creating,
    requesting_certificate,
    updating,

    pub const json_field_names = .{
        .pending_verification = "PENDING_VERIFICATION",
        .in_progress = "IN_PROGRESS",
        .available = "AVAILABLE",
        .importing_custom_certificate = "IMPORTING_CUSTOM_CERTIFICATE",
        .pending_deployment = "PENDING_DEPLOYMENT",
        .awaiting_app_cname = "AWAITING_APP_CNAME",
        .failed = "FAILED",
        .creating = "CREATING",
        .requesting_certificate = "REQUESTING_CERTIFICATE",
        .updating = "UPDATING",
    };
};
