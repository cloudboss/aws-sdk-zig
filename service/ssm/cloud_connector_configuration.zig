const AzureConfiguration = @import("azure_configuration.zig").AzureConfiguration;

/// The configuration that provides access details and targets for connecting to
/// a third-party
/// cloud environment.
pub const CloudConnectorConfiguration = union(enum) {
    /// The access details and targets for connecting to a Microsoft Azure
    /// environment.
    azure_configuration: ?AzureConfiguration,

    pub const json_field_names = .{
        .azure_configuration = "AzureConfiguration",
    };
};
