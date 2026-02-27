pub const AccountTargeting = enum {
    single_account,
    multi_account,

    pub const json_field_names = .{
        .single_account = "SINGLE_ACCOUNT",
        .multi_account = "MULTI_ACCOUNT",
    };
};
