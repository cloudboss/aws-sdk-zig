pub const CertificateBasedAuthStatus = enum {
    disabled,
    enabled,
    enabled_no_directory_login_fallback,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
        .enabled_no_directory_login_fallback = "ENABLED_NO_DIRECTORY_LOGIN_FALLBACK",
    };
};
