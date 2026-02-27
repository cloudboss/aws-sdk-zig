pub const SamlStatusEnum = enum {
    disabled,
    enabled,
    enabled_with_directory_login_fallback,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
        .enabled_with_directory_login_fallback = "ENABLED_WITH_DIRECTORY_LOGIN_FALLBACK",
    };
};
