pub const ResourceSetStatus = enum {
    active,
    out_of_admin_scope,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .out_of_admin_scope = "OUT_OF_ADMIN_SCOPE",
    };
};
