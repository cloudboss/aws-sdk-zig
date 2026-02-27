pub const AppliedLevelEnum = enum {
    account,
    resource,
    all,

    pub const json_field_names = .{
        .account = "ACCOUNT",
        .resource = "RESOURCE",
        .all = "ALL",
    };
};
