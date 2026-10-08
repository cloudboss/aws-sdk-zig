const SellerInformation = @import("seller_information.zig").SellerInformation;

/// Summary information about a product, including the identifier, name, and
/// manufacturer.
pub const ProductInformation = struct {
    /// The entity who manufactured the product.
    manufacturer: SellerInformation,

    /// The unique identifier of the product.
    product_id: []const u8,

    /// The human-readable display name of the product.
    product_name: []const u8,

    pub const json_field_names = .{
        .manufacturer = "manufacturer",
        .product_id = "productId",
        .product_name = "productName",
    };
};
