pub const ResourceNotFoundExceptionReason = enum {
    partner_not_found,
    partner_profile_not_found,
    partner_profile_task_not_found,
    partner_domain_not_found,
    sender_profile_not_found,
    receiver_profile_not_found,
    connection_invitation_not_found,
    connection_not_found,
    verification_not_found,

    pub const json_field_names = .{
        .partner_not_found = "PARTNER_NOT_FOUND",
        .partner_profile_not_found = "PARTNER_PROFILE_NOT_FOUND",
        .partner_profile_task_not_found = "PARTNER_PROFILE_TASK_NOT_FOUND",
        .partner_domain_not_found = "PARTNER_DOMAIN_NOT_FOUND",
        .sender_profile_not_found = "SENDER_PROFILE_NOT_FOUND",
        .receiver_profile_not_found = "RECEIVER_PROFILE_NOT_FOUND",
        .connection_invitation_not_found = "CONNECTION_INVITATION_NOT_FOUND",
        .connection_not_found = "CONNECTION_NOT_FOUND",
        .verification_not_found = "VERIFICATION_NOT_FOUND",
    };
};
