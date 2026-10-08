const ProductInformation = @import("product_information.zig").ProductInformation;

/// A product associated with a listing summary.
pub const ListingSummaryAssociatedEntity = struct {
    /// Information about the associated product.
    product: ?ProductInformation = null,

    pub const json_field_names = .{
        .product = "product",
    };
};
