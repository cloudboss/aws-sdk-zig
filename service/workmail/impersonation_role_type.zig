pub const ImpersonationRoleType = enum {
    full_access,
    read_only,

    pub const json_field_names = .{
        .full_access = "FULL_ACCESS",
        .read_only = "READ_ONLY",
    };
};
