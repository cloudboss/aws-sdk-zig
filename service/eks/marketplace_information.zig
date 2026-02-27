/// Information about an Amazon EKS add-on from the Amazon Web Services
/// Marketplace.
pub const MarketplaceInformation = struct {
    /// The product ID from the Amazon Web Services Marketplace.
    product_id: ?[]const u8,

    /// The product URL from the Amazon Web Services Marketplace.
    product_url: ?[]const u8,

    pub const json_field_names = .{
        .product_id = "productId",
        .product_url = "productUrl",
    };
};
