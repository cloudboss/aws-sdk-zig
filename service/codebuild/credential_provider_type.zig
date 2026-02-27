pub const CredentialProviderType = enum {
    secrets_manager,

    pub const json_field_names = .{
        .secrets_manager = "SECRETS_MANAGER",
    };
};
