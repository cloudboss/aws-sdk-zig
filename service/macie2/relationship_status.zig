/// The current status of the relationship between an account and an associated
/// Amazon Macie administrator account. Possible values are:
pub const RelationshipStatus = enum {
    enabled,
    paused,
    invited,
    created,
    removed,
    resigned,
    email_verification_in_progress,
    email_verification_failed,
    region_disabled,
    account_suspended,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .paused = "Paused",
        .invited = "Invited",
        .created = "Created",
        .removed = "Removed",
        .resigned = "Resigned",
        .email_verification_in_progress = "EmailVerificationInProgress",
        .email_verification_failed = "EmailVerificationFailed",
        .region_disabled = "RegionDisabled",
        .account_suspended = "AccountSuspended",
    };
};
