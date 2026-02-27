pub const ResourceOwner = enum {
    self,
    other_accounts,

    pub const json_field_names = .{
        .self = "SELF",
        .other_accounts = "OTHER_ACCOUNTS",
    };
};
