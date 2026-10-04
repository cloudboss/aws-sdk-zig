const AzureUpdateConfiguration = @import("azure_update_configuration.zig").AzureUpdateConfiguration;

/// The cloud provider configuration for updating a connector. This is a union
/// type that currently supports Azure.
pub const CspmProviderUpdateConfiguration = union(enum) {
    /// The Azure update configuration.
    azure: ?AzureUpdateConfiguration,

    pub const json_field_names = .{
        .azure = "Azure",
    };
};
