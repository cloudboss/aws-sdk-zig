const AzureProviderDetailCreate = @import("azure_provider_detail_create.zig").AzureProviderDetailCreate;

/// The provider-specific configuration details for creating a connector.
pub const ProviderDetailCreate = union(enum) {
    /// The Azure-specific details for creating a connector.
    azure: ?AzureProviderDetailCreate,

    pub const json_field_names = .{
        .azure = "azure",
    };
};
