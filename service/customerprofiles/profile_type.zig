pub const ProfileType = enum {
    account_profile,
    profile,

    pub const json_field_names = .{
        .account_profile = "ACCOUNT_PROFILE",
        .profile = "PROFILE",
    };
};
