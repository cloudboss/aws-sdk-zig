pub const AccessType = enum {
    allow_all,
    deny_all,
    allow_by_default_deny_some,

    pub const json_field_names = .{
        .allow_all = "ALLOW_ALL",
        .deny_all = "DENY_ALL",
        .allow_by_default_deny_some = "ALLOW_BY_DEFAULT_DENY_SOME",
    };
};
