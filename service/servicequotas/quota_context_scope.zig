pub const QuotaContextScope = enum {
    resource,
    account,

    pub const json_field_names = .{
        .resource = "RESOURCE",
        .account = "ACCOUNT",
    };
};
