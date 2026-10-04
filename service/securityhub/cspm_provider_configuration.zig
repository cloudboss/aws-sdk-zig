const AzureProviderConfiguration = @import("azure_provider_configuration.zig").AzureProviderConfiguration;

/// The cloud provider configuration for creating a connector. This is a union
/// type that currently supports Azure.
pub const CspmProviderConfiguration = union(enum) {
    /// The Azure provider configuration.
    azure: ?AzureProviderConfiguration,

    pub const json_field_names = .{
        .azure = "Azure",
    };
};
