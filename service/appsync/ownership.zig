pub const Ownership = enum {
    current_account,
    other_accounts,

    pub const json_field_names = .{
        .current_account = "CURRENT_ACCOUNT",
        .other_accounts = "OTHER_ACCOUNTS",
    };
};
