pub const MemberStatus = enum {
    invited,
    verification_in_progress,
    verification_failed,
    enabled,
    accepted_but_disabled,

    pub const json_field_names = .{
        .invited = "INVITED",
        .verification_in_progress = "VERIFICATION_IN_PROGRESS",
        .verification_failed = "VERIFICATION_FAILED",
        .enabled = "ENABLED",
        .accepted_but_disabled = "ACCEPTED_BUT_DISABLED",
    };
};
