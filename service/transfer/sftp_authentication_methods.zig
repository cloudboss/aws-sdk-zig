pub const SftpAuthenticationMethods = enum {
    password,
    public_key,
    public_key_or_password,
    public_key_and_password,

    pub const json_field_names = .{
        .password = "PASSWORD",
        .public_key = "PUBLIC_KEY",
        .public_key_or_password = "PUBLIC_KEY_OR_PASSWORD",
        .public_key_and_password = "PUBLIC_KEY_AND_PASSWORD",
    };
};
