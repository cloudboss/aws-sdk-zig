pub const PolicyScope = enum {
    account,
    resource,

    pub const json_field_names = .{
        .account = "ACCOUNT",
        .resource = "RESOURCE",
    };
};
