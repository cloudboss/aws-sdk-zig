pub const AuthResources = enum {
    user_pool_only,
    identity_pool_and_user_pool,

    pub const json_field_names = .{
        .user_pool_only = "USER_POOL_ONLY",
        .identity_pool_and_user_pool = "IDENTITY_POOL_AND_USER_POOL",
    };
};
