pub const BusinessValidationCode = enum {
    incompatible_connection_invitation_request,
    incompatible_legal_name,
    incompatible_know_your_business_status,
    incompatible_identity_verification_status,
    invalid_account_linking_status,
    invalid_account_state,
    incompatible_domain,

    pub const json_field_names = .{
        .incompatible_connection_invitation_request = "INCOMPATIBLE_CONNECTION_INVITATION_REQUEST",
        .incompatible_legal_name = "INCOMPATIBLE_LEGAL_NAME",
        .incompatible_know_your_business_status = "INCOMPATIBLE_KNOW_YOUR_BUSINESS_STATUS",
        .incompatible_identity_verification_status = "INCOMPATIBLE_IDENTITY_VERIFICATION_STATUS",
        .invalid_account_linking_status = "INVALID_ACCOUNT_LINKING_STATUS",
        .invalid_account_state = "INVALID_ACCOUNT_STATE",
        .incompatible_domain = "INCOMPATIBLE_DOMAIN",
    };
};
