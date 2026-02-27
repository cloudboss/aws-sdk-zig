const AppRegistryConfiguration = @import("app_registry_configuration.zig").AppRegistryConfiguration;

pub const GetConfigurationResponse = struct {
    /// Retrieves `TagKey` configuration
    /// from an account.
    configuration: ?AppRegistryConfiguration,

    pub const json_field_names = .{
        .configuration = "configuration",
    };
};
