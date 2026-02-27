pub const AmbiguousRoleResolutionType = enum {
    authenticated_role,
    deny,

    pub const json_field_names = .{
        .authenticated_role = "AUTHENTICATED_ROLE",
        .deny = "DENY",
    };
};
