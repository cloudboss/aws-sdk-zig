pub const ResourceStatus = enum {
    active,
    deleting,
    @"error",

    pub const json_field_names = .{
        .active = "ACTIVE",
        .deleting = "DELETING",
        .@"error" = "ERROR",
    };
};
