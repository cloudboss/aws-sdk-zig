pub const IdentitySourceStatus = enum {
    creating,
    active,
    deleting,
    @"error",

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .deleting = "DELETING",
        .@"error" = "ERROR",
    };
};
