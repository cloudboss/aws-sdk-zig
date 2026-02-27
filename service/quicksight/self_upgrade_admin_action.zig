pub const SelfUpgradeAdminAction = enum {
    approve,
    deny,
    verify,

    pub const json_field_names = .{
        .approve = "APPROVE",
        .deny = "DENY",
        .verify = "VERIFY",
    };
};
