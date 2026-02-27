/// The provider configuration required for different ID namespace types.
pub const ProviderIdNameSpaceConfiguration = struct {
    /// The description of the ID namespace.
    description: ?[]const u8,

    /// Configurations required for the source ID namespace.
    provider_source_configuration_definition: ?[]const u8,

    /// Configurations required for the target ID namespace.
    provider_target_configuration_definition: ?[]const u8,

    pub const json_field_names = .{
        .description = "description",
        .provider_source_configuration_definition = "providerSourceConfigurationDefinition",
        .provider_target_configuration_definition = "providerTargetConfigurationDefinition",
    };
};
