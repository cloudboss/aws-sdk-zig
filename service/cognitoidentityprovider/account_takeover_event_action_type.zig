pub const AccountTakeoverEventActionType = enum {
    block,
    mfa_if_configured,
    mfa_required,
    no_action,

    pub const json_field_names = .{
        .block = "BLOCK",
        .mfa_if_configured = "MFA_IF_CONFIGURED",
        .mfa_required = "MFA_REQUIRED",
        .no_action = "NO_ACTION",
    };
};
