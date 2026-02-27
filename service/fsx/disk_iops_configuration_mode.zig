pub const DiskIopsConfigurationMode = enum {
    automatic,
    user_provisioned,

    pub const json_field_names = .{
        .automatic = "AUTOMATIC",
        .user_provisioned = "USER_PROVISIONED",
    };
};
