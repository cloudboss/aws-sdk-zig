pub const RelationshipStatus = enum {
    created,
    invited,
    disabled,
    enabled,
    removed,
    resigned,
    deleted,
    email_verification_in_progress,
    email_verification_failed,
    region_disabled,
    account_suspended,
    cannot_create_detector_in_org_master,

    pub const json_field_names = .{
        .created = "CREATED",
        .invited = "INVITED",
        .disabled = "DISABLED",
        .enabled = "ENABLED",
        .removed = "REMOVED",
        .resigned = "RESIGNED",
        .deleted = "DELETED",
        .email_verification_in_progress = "EMAIL_VERIFICATION_IN_PROGRESS",
        .email_verification_failed = "EMAIL_VERIFICATION_FAILED",
        .region_disabled = "REGION_DISABLED",
        .account_suspended = "ACCOUNT_SUSPENDED",
        .cannot_create_detector_in_org_master = "CANNOT_CREATE_DETECTOR_IN_ORG_MASTER",
    };
};
