pub const ResourceManagedStatus = enum {
    managed,
    account,

    pub const json_field_names = .{
        .managed = "MANAGED",
        .account = "ACCOUNT",
    };
};
