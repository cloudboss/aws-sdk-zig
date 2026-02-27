pub const RouterInputTransitEncryptionKeyType = enum {
    secrets_manager,
    automatic,

    pub const json_field_names = .{
        .secrets_manager = "SECRETS_MANAGER",
        .automatic = "AUTOMATIC",
    };
};
