pub const RoleType = enum {
    process_owner,
    resource_owner,

    pub const json_field_names = .{
        .process_owner = "PROCESS_OWNER",
        .resource_owner = "RESOURCE_OWNER",
    };
};
