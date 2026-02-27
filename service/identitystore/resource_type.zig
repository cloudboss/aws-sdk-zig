pub const ResourceType = enum {
    group,
    user,
    identity_store,
    group_membership,
    resource_policy,

    pub const json_field_names = .{
        .group = "GROUP",
        .user = "USER",
        .identity_store = "IDENTITY_STORE",
        .group_membership = "GROUP_MEMBERSHIP",
        .resource_policy = "RESOURCE_POLICY",
    };
};
