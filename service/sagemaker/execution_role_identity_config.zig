pub const ExecutionRoleIdentityConfig = enum {
    user_profile_name,
    disabled,

    pub const json_field_names = .{
        .user_profile_name = "USER_PROFILE_NAME",
        .disabled = "DISABLED",
    };
};
