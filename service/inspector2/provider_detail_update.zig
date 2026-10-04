const AzureProviderDetailUpdate = @import("azure_provider_detail_update.zig").AzureProviderDetailUpdate;

/// The provider-specific configuration details for updating a connector.
pub const ProviderDetailUpdate = union(enum) {
    /// The Azure-specific details for updating a connector.
    azure: ?AzureProviderDetailUpdate,

    pub const json_field_names = .{
        .azure = "azure",
    };
};
