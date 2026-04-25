const IntegrationV2Type = @import("integration_v2_type.zig").IntegrationV2Type;

/// Defines the structure for the productV2.
pub const ProductV2 = struct {
    /// The URL to the serviceV@ or productV2 documentation about the integration,
    /// which includes how to activate the integration.
    activation_url: ?[]const u8 = null,

    /// The domains or functional areas the productV2 addresses.
    categories: ?[]const []const u8 = null,

    /// The name of the organization or vendor that provides the productV2.
    company_name: ?[]const u8 = null,

    /// Detailed information about the productV2.
    description: ?[]const u8 = null,

    /// The type of integration.
    integration_v2_types: ?[]const IntegrationV2Type = null,

    /// The identifier for the Amazon Web Services Marketplace product associated
    /// with this integration.
    marketplace_product_id: ?[]const u8 = null,

    /// The console URL where you can purchase or subscribe to products.
    marketplace_url: ?[]const u8 = null,

    /// The name of the productV2.
    product_v2_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .activation_url = "ActivationUrl",
        .categories = "Categories",
        .company_name = "CompanyName",
        .description = "Description",
        .integration_v2_types = "IntegrationV2Types",
        .marketplace_product_id = "MarketplaceProductId",
        .marketplace_url = "MarketplaceUrl",
        .product_v2_name = "ProductV2Name",
    };
};
