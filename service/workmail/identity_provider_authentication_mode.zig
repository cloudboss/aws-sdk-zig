pub const IdentityProviderAuthenticationMode = enum {
    identity_provider_only,
    identity_provider_and_directory,

    pub const json_field_names = .{
        .identity_provider_only = "IDENTITY_PROVIDER_ONLY",
        .identity_provider_and_directory = "IDENTITY_PROVIDER_AND_DIRECTORY",
    };
};
