pub const EnvironmentVariableType = enum {
    plaintext,
    secrets_manager,

    pub const json_field_names = .{
        .plaintext = "PLAINTEXT",
        .secrets_manager = "SECRETS_MANAGER",
    };
};
