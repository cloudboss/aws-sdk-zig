const ProductCodeType = @import("product_code_type.zig").ProductCodeType;

/// A list item that contains a product code.
pub const ProductCodeListItem = struct {
    /// The product code ID
    product_code_id: []const u8,

    /// The product code type
    product_code_type: ProductCodeType,

    pub const json_field_names = .{
        .product_code_id = "ProductCodeId",
        .product_code_type = "ProductCodeType",
    };
};
