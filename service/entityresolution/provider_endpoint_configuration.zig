const ProviderMarketplaceConfiguration = @import("provider_marketplace_configuration.zig").ProviderMarketplaceConfiguration;

/// The required configuration fields to use with the provider service.
pub const ProviderEndpointConfiguration = union(enum) {
    /// The identifiers of the provider service, from Data Exchange.
    marketplace_configuration: ?ProviderMarketplaceConfiguration,

    pub const json_field_names = .{
        .marketplace_configuration = "marketplaceConfiguration",
    };
};
