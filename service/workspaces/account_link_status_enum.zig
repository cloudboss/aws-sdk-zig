pub const AccountLinkStatusEnum = enum {
    linked,
    linking_failed,
    link_not_found,
    pending_acceptance_by_target_account,
    rejected,

    pub const json_field_names = .{
        .linked = "LINKED",
        .linking_failed = "LINKING_FAILED",
        .link_not_found = "LINK_NOT_FOUND",
        .pending_acceptance_by_target_account = "PENDING_ACCEPTANCE_BY_TARGET_ACCOUNT",
        .rejected = "REJECTED",
    };
};
