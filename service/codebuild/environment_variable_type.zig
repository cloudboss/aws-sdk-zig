pub const EnvironmentVariableType = enum {
    plaintext,
    parameter_store,
    secrets_manager,

    pub const json_field_names = .{
        .plaintext = "PLAINTEXT",
        .parameter_store = "PARAMETER_STORE",
        .secrets_manager = "SECRETS_MANAGER",
    };
};
