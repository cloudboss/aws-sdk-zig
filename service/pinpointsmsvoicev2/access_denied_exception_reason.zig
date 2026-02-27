pub const AccessDeniedExceptionReason = enum {
    insufficient_account_reputation,
    account_disabled,

    pub const json_field_names = .{
        .insufficient_account_reputation = "INSUFFICIENT_ACCOUNT_REPUTATION",
        .account_disabled = "ACCOUNT_DISABLED",
    };
};
