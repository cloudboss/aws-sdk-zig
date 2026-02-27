pub const ConflictExceptionReason = enum {
    conflict_client_token,
    duplicate_partner,
    incompatible_profile_state,
    incompatible_partner_profile_task_state,
    duplicate_connection_invitation,
    incompatible_connection_invitation_state,
    incompatible_connection_invitation_receiver,
    duplicate_connection,
    incompatible_connection_state,
    incompatible_connection_preferences_revision,
    account_already_verified,
    verification_already_in_progress,

    pub const json_field_names = .{
        .conflict_client_token = "CONFLICT_CLIENT_TOKEN",
        .duplicate_partner = "DUPLICATE_PARTNER",
        .incompatible_profile_state = "INCOMPATIBLE_PROFILE_STATE",
        .incompatible_partner_profile_task_state = "INCOMPATIBLE_PARTNER_PROFILE_TASK_STATE",
        .duplicate_connection_invitation = "DUPLICATE_CONNECTION_INVITATION",
        .incompatible_connection_invitation_state = "INCOMPATIBLE_CONNECTION_INVITATION_STATE",
        .incompatible_connection_invitation_receiver = "INCOMPATIBLE_CONNECTION_INVITATION_RECEIVER",
        .duplicate_connection = "DUPLICATE_CONNECTION",
        .incompatible_connection_state = "INCOMPATIBLE_CONNECTION_STATE",
        .incompatible_connection_preferences_revision = "INCOMPATIBLE_CONNECTION_PREFERENCES_REVISION",
        .account_already_verified = "ACCOUNT_ALREADY_VERIFIED",
        .verification_already_in_progress = "VERIFICATION_ALREADY_IN_PROGRESS",
    };
};
