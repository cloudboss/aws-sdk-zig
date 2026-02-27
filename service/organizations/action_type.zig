pub const ActionType = enum {
    invite_account_to_organization,
    enable_all_features,
    approve_all_features,
    add_organizations_service_linked_role,
    transfer_responsibility,

    pub const json_field_names = .{
        .invite_account_to_organization = "INVITE_ACCOUNT_TO_ORGANIZATION",
        .enable_all_features = "ENABLE_ALL_FEATURES",
        .approve_all_features = "APPROVE_ALL_FEATURES",
        .add_organizations_service_linked_role = "ADD_ORGANIZATIONS_SERVICE_LINKED_ROLE",
        .transfer_responsibility = "TRANSFER_RESPONSIBILITY",
    };
};
