pub const eventScopeCode = enum {
    public,
    account_specific,
    none,

    pub const json_field_names = .{
        .public = "PUBLIC",
        .account_specific = "ACCOUNT_SPECIFIC",
        .none = "NONE",
    };
};
