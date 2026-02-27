pub const DeletionProtectionCheck = enum {
    account_default,
    apply,
    bypass,

    pub const json_field_names = .{
        .account_default = "ACCOUNT_DEFAULT",
        .apply = "APPLY",
        .bypass = "BYPASS",
    };
};
